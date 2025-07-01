x = 0;
y = 0;
angle = 0;

data = {};
original_list = [];
list = [];

board_create_rectangle("main", 320, 200, 75, 75, 75, 75, 0, 0)

board_update();

l_color = #00c000;
l_alpha = 1;
bg_color = c_black;
bg_alpha = 1;

alpha = 0;
scale = 0;
afterimage = false;
afterimage_list = [];

timer = 0;
width = 4;

boardanim_speed = 30;

///@arg {Struct} data
///@arg {Real} alpha
///@arg {Id.Instance} id
function CreateAfterImage(_data, _alpha, _id = obj_battle_board) constructor{
	x = _id.x;
	y = _id.y;
	angle = _id.angle;
	color = _id.l_color;
	alpha = _id.l_alpha * _id.bg_alpha;
	scale = _id.scale;
	
	width = _id.width;
	
	fadeout = _alpha;
	
	data = _data;
	
	static step = function(){
		fadeout -= 0.02;
	}
	static draw = function(){
		draw_set_ca(color, alpha * fadeout);
		draw_board(data);
		draw_set_ca();
	}
}

//枠を描画します
///@arg {Struct} board_data
function draw_board(board_data){
	var _a, _b,
		_offset = board_data.pos;
	if (board_data.type == BOARD_TYPE.POLYGON){
		if (!array_empty(board_data.polydata)){
			var _count = array_length(board_data.polydata);
			
			draw_primitive_begin(pr_trianglestrip);
			for(var i=0;i<_count + 1;i++){
				_a = board_data.polydata[i % _count];
				_b = board_data.polyoffset[i % _count];
				
				draw_vertex(_offset.x + _a.x, _offset.y + _a.y);
				draw_vertex(_offset.x + _b.x, _offset.y + _b.y);
			}
			draw_primitive_end();
		}
	}
	else if (board_data.type == BOARD_TYPE.CIRCLE){
		_a = new Vector2();
		var _p = board_data.precision,
			_ang = board_data.angle;
		draw_primitive_begin(pr_trianglestrip);
		for (var i = 0; i < _p + 1; i++) {
			for (var j = 0; j < 2; j++) {
				_a.x = lengthdir_x(board_data.scale + j * 5 * scale, 360 / _p * i);
				_a.y = lengthdir_y(board_data.scale + j * 5 * scale, 360 / _p * i);
				
				_a.rot(_ang);
				
				draw_vertex(_offset.x + _a.x, _offset.y + _a.y);
			}
		}
		draw_primitive_end();
	}
}

///背景を描画します
///Ear Clipping
///@arg {Struct} board_data
function draw_background(board_data){
	var _offset = board_data.pos;
	if (board_data.type == BOARD_TYPE.POLYGON){
		if (!array_empty(board_data.polydata)){
			var _points = [], _cache = [],
				_polydata = variable_clone(board_data.polydata);
			
			var _count = array_length(_polydata);
			//頂点数が3以下になるまでwhile
			while (_count > 3){
				
				for (var i = 0; i < _count; i++) {
					_points[0] = _polydata[(i + _count - 1) % _count];
					_points[1] = _polydata[i];
					_points[2] = _polydata[(i + 1) % _count];
					
					if (in_ear(i, _polydata, _points, board_data.ccw)){
						array_push(_cache, [_points[0], _points[1], _points[2]]);
						
						array_delete(_polydata, i, 1);
						_count--;
						break;
					}
				}
			}
			//残りはそのまま
			array_push(_cache, [_polydata[0], _polydata[1], _polydata[2]]);
			
			draw_primitive_begin(pr_trianglelist);
			for (var i = 0; i < array_length(_cache); i++) {
				for (var j = 0; j < 3; j++) {
					if (BOARD_BG_COLOR_DEBUG) draw_set_color(make_color_hsv(((i * 3 + j) * 32) % 255, 255, 255))
					draw_vertex(_offset.x + _cache[i, j].x, _offset.y + _cache[i, j].y);
				}
			}
			draw_primitive_end();
		}
	}
	else if (board_data.type == BOARD_TYPE.CIRCLE){
		var _a = new Vector2(),
			_p = board_data.precision,
			_ang = board_data.angle;
		
		draw_primitive_begin(pr_trianglefan);
		draw_vertex(_offset.x, _offset.y);
		
		for (var i = 0; i < _p + 1; i++) {
			_a.x = lengthdir_x(board_data.scale, 360 / _p * i);
			_a.y = lengthdir_y(board_data.scale, 360 / _p * i);
			
			_a.rot(_ang);
			
			draw_vertex(_offset.x + _a.x, _offset.y + _a.y);
		}
		draw_primitive_end()
	}
}