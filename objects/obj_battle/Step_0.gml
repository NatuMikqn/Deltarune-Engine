if (keyboard_check_pressed(ord("1"))) {
	dbg_info = !dbg_info;
}

//次のstatus実行用
if (next_state_timer >= 0){
	next_state_timer--
	if (next_state_timer == 0){
		battle_set_state(next_state);
	}
}

if (mouse_wheel_up()){
	dbg_screen_alpha+=0.05
	if dbg_screen_alpha > 1{
		dbg_screen_alpha = 1
	}
}
if (mouse_wheel_down()){
	dbg_screen_alpha-=0.05
	if dbg_screen_alpha < 0{
		dbg_screen_alpha = 0
	}
}
if (keyboard_check(vk_control) && keyboard_check_pressed(ord("S"))){
	dbg_screen_img++
	if (dbg_screen_img >= sprite_get_number(spr_screen_awase)) dbg_screen_img = 0
}
//自ターン処理
if (state == BATTLE_STATE.MYTURN){
	//ボタン行動選択
	if (battle_get_selectmode() == DIALOG_UI.BUTTON){
		var _left = input_check_pressed(INPUT.LEFT),
			_right = input_check_pressed(INPUT.RIGHT);
		if (_left || _right){
			select_button[charturn] += _right - _left;
			
			var _len = array_length(battle_get_buttonlist())
			if (select_button[charturn] < 0) select_button[charturn] = _len - 1;
			else if (select_button[charturn] > (_len - 1)) select_button[charturn] = 0;
			
			audio_play_sound(snd_select, 0, 0)
		}
		if (input_check_pressed(INPUT.CONFIRM)){
			battle_custom_event(battle_get_buttonlist()[select_button[charturn]].get_type());
		}else
		//キャンセルキーで前のキャラクターに戻る
		if (input_check_pressed(INPUT.CANCEL)){
			battle_prev_char();
		}
	}else{ //ボタン選択以外の場合
		//点滅リセット -> 
		//選択時点滅リセット -> 
		if (instance_exists(enemy_select_target)) enemy_select_target.flashpower = 0.2 + dsin(get_worldtimer() * 4) * 0.1;
		
		if (battle_get_selectmode() == DIALOG_UI.SELECTENEMY){
			if (input_check_pressed(INPUT.CONFIRM)){
				nextfunc();
			}
		}
		else if (battle_get_selectmode() == DIALOG_UI.LIST){
			if (input_check_pressed(INPUT.CONFIRM)){
				nextfunc();
			}
		}
		//ボタン操作に戻る
		if (input_check_pressed(INPUT.CANCEL)){
			battle_dialog_button();
		}
	}
}
//敵メッセージ時
if (state == BATTLE_STATE.ENEMY_TALK){
	if (instance_exists(obj_typewriter_object) || true){
		battle_set_state(BATTLE_STATE.ENEMY_IN)
	}
}
//枠アニメーション
if (state == BATTLE_STATE.ENEMY_IN){
	if (!easing_exists("board_anim")){
		battle_set_state(BATTLE_STATE.ENEMY)
	}
}
if (state == BATTLE_STATE.ENEMY){
	//TODO - デバッグ機能 後に消す
	if input_check_pressed(INPUT.MENU){
		battle_turn_end()
	}
}
//枠アニメーション
if (state == BATTLE_STATE.ENEMY_END){
	if (!easing_exists("board_anim")){
		battle_set_state(BATTLE_STATE.MYTURN);
	}
}

timer++