if (keyboard_check_pressed(ord("1"))) {
	dbg_info = !dbg_info;
}

// 次のバトルステータス変更用
if (next_state_timer >= 0){
	next_state_timer--
	if (next_state_timer == 0){
		battle_set_state(next_state);
	}
}

//自ターン処理
if (state == BATTLE_STATE.MYTURN){
	//ボタン行動選択
	if (battle_get_selectmode() == DIALOG_UI.BUTTON){
		var _left = input_check_pressed(INPUT.LEFT),
			_right = input_check_pressed(INPUT.RIGHT);
		// 左右キーどちらか押したら
		if (_left || _right){
			select_button[charturn] += _right - _left;
			
			var _len = array_length(battle_get_buttonlist())
			if (select_button[charturn] < 0) select_button[charturn] = _len - 1;
			else if (select_button[charturn] > (_len - 1)) select_button[charturn] = 0;
			
			audio_play_sound(snd_select, 0, 0)
		}
		
		// 決定キーで、選択したボタンのタイプによって処理を行う
		if (input_check_pressed(INPUT.CONFIRM)) {
			battle_button_event(battle_get_buttonlist()[select_button[charturn]].get_type());
		}
		//キャンセルキーで前のキャラクターに戻る
		else if (input_check_pressed(INPUT.CANCEL)) {
			battle_prev_char();
		}
	}else{ //ボタン選択以外の場合
		//点滅リセット -> 
		//選択時点滅リセット -> 
		if (instance_exists(enemy_select_target)) {
			enemy_select_target.flashpower = 0.2 + dsin(get_worldtimer() * 4) * 0.1;
		}
		
		// 選択中の仲間がいる場合、その対象を点滅させる
		if (instance_exists(team_select_target)) {
			team_select_target.flashpower = 0.2 + dsin(get_worldtimer() * 4) * 0.1;
		}
		// 選択中の敵がいる場合、その対象を点滅させる
		if (instance_exists(enemy_select_target)) {
			enemy_select_target.flashpower = 0.2 + dsin(get_worldtimer() * 4) * 0.1;
		}
		
		// 決定キーにより、事前に設定された関数を実行する
		if (input_check_pressed(INPUT.CONFIRM)) {
			if (is_method(nextfunc)) {
				nextfunc();
			}
		}
		// 進行度に関わらず、戻れる場合はボタン操作に戻る
		if (can_back) {
			if (input_check_pressed(INPUT.CANCEL)){
				battle_dialog_button();
			}
		}
	}
}
// 敵メッセージ時
if (state == BATTLE_STATE.ENEMY_TALK){
	if (instance_exists(obj_typewriter_object) || true){
		battle_set_state(BATTLE_STATE.ENEMY_IN)
	}
}
// 枠アニメーション
if (state == BATTLE_STATE.ENEMY_IN){
	if (!easing_exists("board_anim")){
		battle_set_state(BATTLE_STATE.ENEMY)
	}
}
if (state == BATTLE_STATE.ENEMY){
	//TODO - ターン強制終了 後に消す
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