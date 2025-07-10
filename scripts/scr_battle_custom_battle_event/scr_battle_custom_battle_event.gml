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
				audio_play_sound(snd_confirm, 0, 0);
				var _list = [];
				array_push(_list, new BattleDialogList("ACTLIST1", "DESC1"));
				array_push(_list, new BattleDialogList("ACTLIST2", "<color red>DESC2"));
				array_push(_list, new BattleDialogList("ACTLIST3", "<color yellow>DESC3"));
				battle_dialog_list(_list, function(){
					audio_play_sound(snd_confirm, 0, 0);
					battle_next_char(BATTLE_CHAR_ACTION.ACT);
				});
			})
			break;
		case BUTTON_TYPE.ITEM:
			audio_play_sound(snd_confirm, 0, 0);
			var _list = [];
			array_push(_list, new BattleDialogList("ITEM1", "DESC1"));
			array_push(_list, new BattleDialogList("ITEM2", "DESC22"));
			array_push(_list, new BattleDialogList("ITEM3", "DESC333"));
			array_push(_list, new BattleDialogList("ITEM4", "DESC4444"));
			array_push(_list, new BattleDialogList("ITEM5", "DESC55555"));
			battle_dialog_list(_list, function(){
				audio_play_sound(snd_confirm, 0, 0);
				battle_next_char(BATTLE_CHAR_ACTION.ITEM);
			});
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