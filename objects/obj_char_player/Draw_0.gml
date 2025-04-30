event_inherited();

draw_set_color(c_red)
var _v1 = vector2rot(-15, 0, 0, 0, -dir+90),
	_v2 = vector2rot(15, 40, 0, 0, -dir+90)
draw_rectangle(x + _v1.x, y + _v1.y, x + _v2.x, y + _v2.y, true)
draw_set_color(c_white)