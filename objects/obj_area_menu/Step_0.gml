if (input_check_pressed(INPUT.MENU) && !open_child) {
	is_open = !is_open;
	area_get_player().movable = !is_open;
	
	if (is_open) {
		easing_run(id, "anim_open", 3, 1, anim_open, 1 - anim_open, 12);
	} else {
		easing_run(id, "anim_open", 3, 1, anim_open, -anim_open, 12);
	}
}

if (is_open && !open_child) {
	if (input_check_pressed(INPUT.CONFIRM)) {
		now_instance = instance_create_depth(0, 0, 0, menu_objects[select]);
		open_child = true;
		audio_play_sound(snd_confirm, 0, 0);
	}
	var _left = input_check_pressed(INPUT.LEFT);
	var _right = input_check_pressed(INPUT.RIGHT);
	var _input = _right - _left;
	if (_left || _right) {
		select += _input;
		audio_play_sound(snd_select, 0, 0);
		
		if (select < 0) {
			select = 0;
		}
		if (select > 3) {
			select = 3;
		}
	}
}