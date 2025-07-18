/// update
var _defsize = get_default_screensize();
var _s = fullscreen[fullscreen_select];
if (_s.x < 0){
	window_enable_borderless_fullscreen(_s.x == -3 || _s.x == -4);
	dotbydot = (_s.x % 2 == 0);
	window_set_fullscreen(true);
	if (dotbydot){
		var _dpsize = new Vector2(
				display_get_width(),
				display_get_height()
			),
			_dpq = _dpsize.copy().q(_defsize),
			_min = _dpq.get_min()
		
		_dpsize.sub(_defsize.mul(_min)).divide(2);
		display_set_gui_maximize(_min, _min, _dpsize.x, _dpsize.y);
		
	}else{
		display_set_gui_size(_defsize.x, _defsize.y);
	}
}else{
	window_set_fullscreen(false);
	window_set_size(_s.x, _s.y);
	display_set_gui_size(_defsize.x, _defsize.y);
}
window_center();