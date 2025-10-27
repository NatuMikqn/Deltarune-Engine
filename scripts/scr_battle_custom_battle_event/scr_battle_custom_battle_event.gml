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
				//ダイアログリスト作成
				var _list = [];
				//キャラACT一覧取得
				var _actlist = battle_act_get();
				for (var i = 0; i < array_length(_actlist); i++) {
					array_push(_list, _actlist[i].data);
				}
				battle_dialog_list(_list, function(){
					audio_play_sound(snd_confirm, 0, 0);
					battle_next_charturn(BATTLE_CHAR_ACTION.ACT);
				});
			})
			break;
		case BUTTON_TYPE.ITEM:
			audio_play_sound(snd_confirm, 0, 0);
			var _list = [
				new BattleDialogList("ITEM1", "DESC1"),
				new BattleDialogList("ITEM2", "DESC22"),
				new BattleDialogList("ITEM3", "DESC333"),
			];
			battle_dialog_list(_list, function(){
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