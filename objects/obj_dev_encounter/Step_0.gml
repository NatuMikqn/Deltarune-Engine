if (overworld_state_equals(OW_STATE.FIELD)){
	var _shift = 1 + keyboard_check(vk_shift) * 4
	if (keyboard_check_pressed(vk_pagedown)){
		encounter_set_id(encounter_get_id()+_shift)
	}
	if (keyboard_check_pressed(vk_pageup)){
		encounter_set_id(encounter_get_id()-_shift)
		if (encounter_get_id() < -1) encounter_set_id(-1)
	}
	if (keyboard_check_pressed(vk_f3)){
		if (check_enemyid()) encounter_start()
	}
}