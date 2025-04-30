depth = DEPTH.BOARD

x = 320;
y = 200;
up = 60;
down = 60;
left = 140;
right = 140;
angle = 0;

l_color = #00c000;
l_alpha = 1;
bg_color = c_black;
bg_alpha = 1;

alpha = 1;
scale = 0;
afterimage = false;
afterimage_list = [];

timer = 0;
width = 4;

///@arg {real} alpha
///@arg {Id.Instance} id
function CreateAfterimage(_alpha, _id = obj_battle_board) constructor{
	x = _id.x;
	y = _id.y;
	up = _id.up;
	down = _id.down;
	left = _id.left;
	right = _id.right;
	angle = _id.angle;
	
	color = _id.l_color;
	alpha = _id.l_alpha * _id.bg_alpha;
	scale = _id.scale;
	
	width = _id.width;
	
	ai_alpha = _alpha;
	static step = function(){
		ai_alpha -= 0.02
	}
	static draw = function(){
		draw_set_ca(color, alpha * ai_alpha)
		draw_board(x, y, left * scale, right * scale, up * scale, down * scale, angle, width * scale)
		draw_set_ca()
	}
}
/*
///@arg {array} point
function draw_board(_point){
	_point = array_concat(_point, [_point[0], _point[1]])
	var _count = array_length(_point) - 2,
		_total = 0
	for(var i=0;i<_count;i++){
		draw_line(_point[i][0], _point[i][1], _point[i+1][0], _point[i+1][1])
		draw_line(_point[i+1][0], _point[i+1][1], _point[i+2][0], _point[i+2][1])
		
		var _dir1 = point_direction(_point[i][0], _point[i][1], _point[i+1][0], _point[i+1][1]),
			_dir2 = point_direction(_point[i+1][0], _point[i+1][1], _point[i+2][0], _point[i+2][1])
		
		_total += angle_difference(_dir2, _dir1)
	}
	var _plus = _total >= 0
	draw_set_color(c_red)
	draw_set_alpha(0.2)
	
	draw_primitive_begin(pr_trianglestrip)
	for(var i=0;i<_count+1;i++){
		var _a = _point[i],
			_a1 = _point[(_count - 1 + i) % (_count)],
			_a2 = _point[(_count + 1 + i) % (_count)],
			_d1 = angle_difference(point_direction(_a[0], _a[1], _a1[0], _a1[1]), 0),
			_d2 = angle_difference(point_direction(_a[0], _a[1], _a2[0], _a2[1]), 0),
			_pd = lerp(_d1, _d2, 0.5),
			_dir = _pd + 180 * (_d1 <= _d2) - 180 * (_plus),
			_dt = width
		
		var _t1 = _a[0] + lengthdir_x(_dt, _dir)
		var _t2 = _a[1] + lengthdir_y(_dt, _dir)
		
		draw_line(_a[0], _a[1], _t1, _t2)
		draw_vertex(_a[0], _a[1])
		draw_vertex(_t1, _t2)
		
		draw_text(_point[i][0], _point[i][1]+0, _d1)
		draw_text(_point[i][0], _point[i][1]+10, _d2)
		draw_text(_point[i][0], _point[i][1]+20, _dir)
		draw_text(_point[i][0], _point[i][1]+30, dsin(abs(_pd)))
		draw_text(_point[i][0], _point[i][1]+40, dcos(abs(_pd)))
	}
	draw_primitive_end()
}*/