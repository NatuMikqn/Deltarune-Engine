event_inherited();

draw_set_color(c_red)
var _v1 = new Vector2(-15, 0).rot(-dir+90),
	_v2 = new Vector2(15, 40).rot(-dir+90)
draw_rectangle(x + _v1.x, y + _v1.y, x + _v2.x, y + _v2.y, true)
draw_set_color(c_white)
draw_text(camera_get_viewpos_x(), camera_get_viewpos_y(), "test")