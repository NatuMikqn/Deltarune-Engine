if (keyboard_check_pressed(vk_space)) {
	awase = !awase;
}

if (awase) {
	if (mouse_wheel_up()){
		dbg_screen_alpha += 0.05
		if dbg_screen_alpha > 1{
			dbg_screen_alpha = 1
		}
	}
	if (mouse_wheel_down()){
		dbg_screen_alpha -= 0.05
		if dbg_screen_alpha < 0{
			dbg_screen_alpha = 0
		}
	}
	
	if (keyboard_check(vk_control) && keyboard_check_pressed(ord("S"))){
		dbg_screen_img++
		if (dbg_screen_img >= sprite_get_number(spr_screen_awase)) dbg_screen_img = 0
	}
}

time_test += delta_time / 1000;