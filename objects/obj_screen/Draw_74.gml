
var _defsize = get_default_screensize(),
	_dpsize = new Vector2()

if (window_get_fullscreen()){
	_dpsize.set(
			display_get_width(),
			display_get_height()
		)
}else{
	_dpsize.set(
			window_get_width(),
			window_get_height()
		)
}

var _min = _dpsize.copy().q(_defsize).get_min()


var _pos = _dpsize.copy().sub(_defsize.mul(_min)).divide(2 * _min);
var _q = _dpsize.copy().q(_defsize).get_max();
if (dotbydot) draw_surface_ext(surface_get_blur(application_surface, 8, 8, true), -_pos.x, -_pos.y, _q.x, _q.y, 0, c_gray, 1);

draw_surface(application_surface, 0, 0);
draw_text(60, 80, _dpsize)
draw_text(60, 100, _min)
draw_text(60, 120, _defsize)
draw_text(60, 140, _pos)