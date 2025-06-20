depth = DEPTH.BOARD

x = 320;
y = 200;
polygons = {
	main : [
		new Vector2(-75, -75),
		new Vector2(-75, 75),
		new Vector2(75, 75),
		new Vector2(75, -75),
	]
}
polygons_offset = {
	main : []
}

angle = 0;

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

///@arg {real} alpha
///@arg {Id.Instance} id
function CreateAfterimage(_alpha, _id = obj_battle_board) constructor{
	x = _id.x;
	y = _id.y;
	polygons = variable_clone(_id.polygons)
	polygons_offset = variable_clone(_id.polygons_offset)
	angle = _id.angle;
	
	color = _id.l_color;
	alpha = _id.l_alpha * _id.bg_alpha;
	scale = _id.scale;
	
	width = _id.width;
	
	fadeout = _alpha;
	static step = function(){
		fadeout -= 0.02
	}
	static draw = function(){
		draw_set_ca(color, alpha * fadeout)
		draw_board(polygons, polygons_offset, scale, angle)
		draw_set_ca()
	}
}

//枠を描画します
function draw_board(polygons, offsets, scale, angle){
	if (!array_empty(offsets.main)){
		var _count = array_length(polygons.main);
		var _a, _b;
		
		draw_primitive_begin(pr_trianglestrip);
		for(var i=0;i<_count + 1;i++){
			_a = polygons.main[i % _count].copy().mul(scale);
			_b = offsets.main[i % _count].copy().mul(scale);
			
			if (angle % 360 != 0){
				_a.rot(angle);
				_b.rot(angle);
			}
			
			draw_vertex(x + _a.x, y + _a.y)
			draw_vertex(x + _b.x, y + _b.y)
		}
		draw_primitive_end()
	}
}

board_update();