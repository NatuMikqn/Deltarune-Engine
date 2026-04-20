if (awase) {
	draw_sprite_ext(spr_screen_awase, dbg_screen_img, 0, 0, 0.5, 0.5, 0, c_white, dbg_screen_alpha);
}

if (show_info) {
	var _text = "";
	
	_text += $"fps: {fps} <{fps_real}>\n";
	_text += $" - maximum: {game_get_speed(gamespeed_fps)} D:{game_get_speed(gamespeed_fps) / (frameskip_get() + 1)}\n";
	
	_text += $"room: {room_get_name(room)}\n";
	_text += $"mouse: {mouse_x}, {mouse_y}\n";
	_text += $"time test: {gametime_to_dtime(time_test * 1000)}";
	
	draw_set_colour(c_black);
	draw_text(1, 1, _text);
	draw_set_colour(c_yellow);
	draw_text(0, 0, _text);
	draw_set_colour(c_white);
}