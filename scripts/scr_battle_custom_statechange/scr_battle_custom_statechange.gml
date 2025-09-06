///@arg {real} state
function battle_set_state(_state){
	with (obj_battle){
		state = _state
		//ここでそれぞれの行動(変更時のみ)をここに入力
		switch _state{
			case BATTLE_STATE.MYTURN:
				if (team_get_count() == 0){
					battle_set_state(BATTLE_STATE.ENEMY_TALK)
				}else{
					battle_show_dialog(false);
					event_user(0)
					with(obj_battle_ui){
						event_user(2)
						event_user(1)
					}
				}
				
				break;
			
			case BATTLE_STATE.ENEMY_TALK:
				
				break;
			
			case BATTLE_STATE.ENEMY_IN:
				with(obj_battle_enemy) event_user(1);
				with(obj_battle_turn) event_user(1);
				if (!instance_exists(obj_battle_turn)){
					with(obj_battle_board) event_user(0);
				}else{
					battle_set_state(BATTLE_STATE.MYTURN)
				}
				break;
			
			case BATTLE_STATE.ENEMY:
				with(obj_battle_turn) event_user(3);
				break;
			
			case BATTLE_STATE.ENEMY_END:
				with(obj_battle_turn) event_user(4);
				with(obj_battle_board) event_user(1);
				break;
		}
		
	}
}