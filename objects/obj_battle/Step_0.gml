if (next_state_timer >= 0){
	next_state_timer--
	if (next_state_timer == 0){
		battle_set_state(next_state);
	}
}

if mouse_wheel_up(){
	dbg_screen_alpha+=0.05
	if dbg_screen_alpha > 1{
		dbg_screen_alpha = 1
	}
}
if mouse_wheel_down(){
	dbg_screen_alpha-=0.05
	if dbg_screen_alpha < 0{
		dbg_screen_alpha = 0
	}
}
if keyboard_check(vk_control) && keyboard_check_pressed(ord("S")){
	dbg_screen_img++
	if (dbg_screen_img >= sprite_get_number(spr_screen_debug)) dbg_screen_img = 0
}
if (state == BATTLE_STATE.MYTURN){
	if input_check_pressed(INPUT.LEFT){
		select_list[charturn][select_step]--
		if (select_list[charturn][select_step] < 0) select_list[charturn][0] = 4
		audio_play_sound(snd_select, 0, 0)
	}
	if input_check_pressed(INPUT.RIGHT){
		select_list[charturn][select_step]++
		if (select_list[charturn][select_step] > 4) select_list[charturn][0] = 0
		audio_play_sound(snd_select, 0, 0)
	}
	if input_check_pressed(INPUT.CONFIRM){
		var _sl = select_list[charturn]
		switch(select_step){
			case 0:
				audio_play_sound(snd_confirm, 0, 0)
				if (_sl[0] == BUTTON.FIGHT){
					battle_tension_add_history(0)
					battle_next_char(1)
				}else
				if (_sl[0] == BUTTON.ACT){
					battle_tension_add_history(0)
					battle_next_char(2)
				}else
				if (_sl[0] == BUTTON.ITEM){
					battle_tension_add_history(0)
					battle_next_char(3)
				}else
				if (_sl[0] == BUTTON.SPARE){
					battle_tension_add_history(0)
					battle_next_char(10)
				}else
				if (_sl[0] == BUTTON.DEFEND){
					battle_tension_add(16)
					battle_team_set_anim(team_get_flag(charturn, TEAMCHAR_FLAG.BATTLE_OBJ), BATTLE_TEAM_ANIM.DEFEND, BATTLE_ANIM_LOOP.ONLY)
					battle_next_char(4)
				}
		}
	}else
	if input_check_pressed(INPUT.CANCEL){
		battle_prev_char()
		
	}
	if input_check_pressed(INPUT.MENU){
		battle_set_state(BATTLE_STATE.ENDTURN)
	}
}
if (state == BATTLE_STATE.ENEMYTURN){
	if input_check_pressed(INPUT.MENU){
		battle_set_state(BATTLE_STATE.ENDTURN)
	}
}

timer++