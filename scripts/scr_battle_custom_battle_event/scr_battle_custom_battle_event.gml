function battle_custom_event(_type){
	switch (_type) {
		case BUTTON_TYPE.FIGHT:
			audio_play_sound(snd_confirm, 0, 0);
			battle_dialog_enemyselect(function(){
				audio_play_sound(snd_confirm, 0, 0);
				battle_next_char(BATTLE_CHAR_ACTION.FIGHT);
			})
			break;
		case BUTTON_TYPE.ACT:
			audio_play_sound(snd_confirm, 0, 0);
			battle_dialog_enemyselect(function(){
				var _list = []
				array_push(_list, new BattleDialogList("TEST1", "DESC1"))
				array_push(_list, new BattleDialogList("TEST1", "DESC1"))
				array_push(_list, new BattleDialogList("TEST1", "DESC1"))
				array_push(_list, new BattleDialogList("TEST1", "DESC1"))
				array_push(_list, new BattleDialogList("TEST1", "DESC1"))
				battle_dialog_list(_list)
			})
			break;
		case BUTTON_TYPE.ITEM:
			audio_play_sound(snd_confirm, 0, 0);
			var _list = []
			array_push(_list, new BattleDialogList("TEST1", "DESC1"))
			array_push(_list, new BattleDialogList("TEST1", "DESC1"))
			array_push(_list, new BattleDialogList("TEST1", "DESC1"))
			array_push(_list, new BattleDialogList("TEST1", "DESC1"))
			array_push(_list, new BattleDialogList("TEST1", "DESC1"))
			battle_dialog_list(_list)
			break;
		case BUTTON_TYPE.SPARE:
			audio_play_sound(snd_confirm, 0, 0);
			battle_dialog_enemyselect(function(){
				audio_play_sound(snd_confirm, 0, 0);
				battle_next_char(BATTLE_CHAR_ACTION.SPARE);
			})
			break;
		case BUTTON_TYPE.DEFEND:
			audio_play_sound(snd_confirm, 0, 0);
			battle_next_char(BATTLE_CHAR_ACTION.DEFEND);
			break;
	}
}