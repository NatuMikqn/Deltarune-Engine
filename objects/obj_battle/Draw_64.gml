surface_set_target(srf_battle);
alphafix(true);
draw_sprite_ext(spr_screen_awase, dbg_screen_img, 0, 0, 0.5, 0.5, 0, c_white, dbg_screen_alpha);
surface_reset_target();

draw_surface(srf_battle, 0, 0);

if (dbg_info) {
	draw_sprite_ext(spr_pixel, 0, 0, 0, 640, 480, 0, c_black, 0.4);
	var _names = variable_instance_get_names(id);
	var _text = "";
	for (var i = 0; i < array_length(_names); i++) {
		_text += $"{_names[i]} : {variable_instance_get(id, _names[i])}\n";
	}
	draw_set_font(fnt_8bit);
	draw_set_colour(c_black);
	draw_text(9, 5, _text);
	draw_set_colour(c_white);
	draw_text(8, 4, _text);
}
alphafix(false);