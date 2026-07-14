surface_set_target(top_screen);

if (anim_open > 0) {
	draw_sprite_ext(spr_pixel, 0, 0, 0, 640, 80, 0, c_black, 1);
	
	for (var i = 0; i < 4; i++) {
		var _img = (select == i ? (open_child ? 2 : 1) : 0);
		
		draw_sprite_ext(image_list[i], _img, 120 + i * 100, 20, 2, 2, 0, c_white, 1);
	}
}

surface_reset_target();

surface_set_target(bottom_screen);

if (anim_open > 0) {
	draw_sprite_ext(spr_pixel, 0, 0, 419, 640, 61, 0, c_black, 1);
	draw_sprite_ext(spr_pixel, 0, 0, 417, 640, 2, 0, #332033, 1);
	
	draw_chatlist(419);
}

surface_reset_target();

surface_set_target(center_screen);

with (now_instance) event_user(0);

surface_reset_target();

draw_set_colour(c_white);
draw_set_align(0);