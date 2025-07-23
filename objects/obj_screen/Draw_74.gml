
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
if (_dpsize.get_min() > 0){
	
	if (dotbydot){
		draw_surface_ext(surface_get_blur(application_surface, 8, 8, true), backblur_pos.x, backblur_pos.y, backblur_size, backblur_size, 0, c_gray, 1);
		draw_sprite_ext(spr_pixel, 0, -1, -1, _defsize.x + 1, 1, 0, c_white, 1)
		draw_sprite_ext(spr_pixel, 0, -1, 0, 1, _defsize.y + 1, 0, c_white, 1)
		draw_sprite_ext(spr_pixel, 0, _defsize.x, -1, 1, _defsize.y + 1, 0, c_white, 1)
		draw_sprite_ext(spr_pixel, 0, 0, _defsize.y, _defsize.x + 1, 1, 0, c_white, 1)
	}
	
	draw_surface(application_surface, 0, 0);
}