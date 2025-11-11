function battle_custom_event(_type){
	switch (_type) {
		case BUTTON_TYPE.FIGHT:
			audio_play_sound(snd_confirm, 0, 0);
			battle_dialog_enemyselect(function(){
				audio_play_sound(snd_confirm, 0, 0);
				battle_next_charturn(BATTLE_CHAR_ACTION.FIGHT);
			})
			break;
		case BUTTON_TYPE.ACT:
			audio_play_sound(snd_confirm, 0, 0);
			battle_dialog_enemyselect(function(){
				audio_play_sound(snd_confirm, 0, 0);
				// キャラACT更新
				battle_act_update();
				battle_show_dialog_list();
			})
			break;
		case BUTTON_TYPE.ITEM:
			audio_play_sound(snd_confirm, 0, 0);
			
			// ダイアログ内容設定
			new BattleActBuilder("item1").set_infomation("ITEM1", "DESC1").build();
			new BattleActBuilder("item2").set_infomation("ITEM2", "DESC22").build();
			new BattleActBuilder("item3").set_infomation("ITEM3", "DESC333").build();
			
			battle_show_dialog_list(function(){
				audio_play_sound(snd_confirm, 0, 0);
				battle_next_charturn(BATTLE_CHAR_ACTION.ITEM);
			});
			break;
		case BUTTON_TYPE.SPARE:
			audio_play_sound(snd_confirm, 0, 0);
			battle_dialog_enemyselect(function(){
				audio_play_sound(snd_confirm, 0, 0);
				battle_next_charturn(BATTLE_CHAR_ACTION.SPARE);
			})
			break;
		case BUTTON_TYPE.DEFEND:
			audio_play_sound(snd_confirm, 0, 0);
			battle_next_charturn(BATTLE_CHAR_ACTION.DEFEND);
			break;
	}
}