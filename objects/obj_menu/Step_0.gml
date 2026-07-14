switch (select_state) {
	case MENU_SELECT_STATE.LIST_SELECT:
		if (selecting.now_id < 3) {
			if (input_check_pressed(INPUT.CONFIRM)) {
				selecting.disable = true;
				select_state = MENU_SELECT_STATE.CHECK_LOAD;
				select_saveid = selecting.now_id;
				cl_select = 0;
			}
		}
		break;
	
	case MENU_SELECT_STATE.CHECK_LOAD:
		if (input_check_pressed(INPUT.CONFIRM)) {
			if (cl_select == 0) {
				room_goto(rm_area_test);
				audio_stop_all();
			} else {
				select_state = MENU_SELECT_STATE.LIST_SELECT;
				selecting.disable = false;
			}
		}
		if (input_check_pressed(INPUT.CANCEL)) {
			select_state = MENU_SELECT_STATE.LIST_SELECT;
			selecting.disable = false;
		}
		
		if (input_check_pressed(INPUT.RIGHT)) {
			if (cl_select == 0) {
				cl_select = 1;
			}
		}
		if (input_check_pressed(INPUT.LEFT)) {
			if (cl_select == 1) {
				cl_select = 0;
			}
		}
		
		break;
}