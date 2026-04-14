
/// 敵指定モード
/// @arg {Function} nextfunction 敵選択後の関数
function battle_state_dialog_enemyselect(_nextfunc)
{
	var _enemy, _len, _ids = battle_get_enemy_ids();
	with (obj_battle){
		battle_dialog_cleanup();
		battle_set_selectmode(DIALOG_UI.SELECTENEMY);
		battle_set_nextfunc(_nextfunc);
		typewriter_choice_set_heartpos(-17, 18);
		
		obj_battle.enemy_select_target = _ids[0];
		
		_len = array_length(battle_get_enemy_ids());
		for (var i = 0; i < _len; i++) {
			_enemy = battle_get_enemy_ids()[i].data;
			new TypeWriterBuilder(80, 375 + i * 30, $"<skipped true>{_enemy.get_name()}")
				.set_font("normal")
				.set_scale(2, 2)
				.set_depth(DEPTH.UI_TEXT)
				.set_surface(obj_battle, battle_get_surface_varname())
				.enable_interaction(false)
				.enable_instance(true)
				.enable_choice(i)
				.set_tag("BattleDialogBoxSelect")
				.set_visible(i < 3)
				.build();
		}
		typewriter_choice_changed(function (_i, _prev) {
			//敵のホワイトフラッシュ再適応
			var _ids = battle_get_enemy_ids();
			obj_battle.enemy_select_target = _ids[_i];
			
			_ids[_prev].flashpower = 0;
			var _list = typewriter_get_ext("BattleDialogBoxSelect");
			var _choice;
			var _len = array_length(_list);
			var _start = floor(_i / 3) * 3;
			//var _loopcount = min(_len - _start, 3);
			for (var i = 0; i < _len; i++) {
				_choice = _list[i].data.choice_id;
				_list[i].y = 375 + (_choice - _start) * 30;
				_list[i].data.visible = (_start == (floor(_choice / 3) * 3));
			}
		});
	}
}

/// 汎用リスト表示
/// @arg {Function} nextfunction 未指定の場合はBattleDialogListの関数を実行するようになります。
function battle_state_dialog_list(_nextfunc = function(){
	// 選択したfunc実行
	var _func = battle_dialog_get_nextfunc();
	
	if (is_undefined(_func)) return;
	
	_func();
})
{
	var _datalist = battle_act_get();
	var _dialogdatalist = [];
	with (obj_battle){
		battle_dialog_cleanup();
		typewriter_choice_enable_reverse_v(BATTLE_DIALOG_ENABLE_LOOP);
		battle_set_selectmode(DIALOG_UI.LIST);
		typewriter_choice_set_heartpos(-12, 18);
		
		//リストが何もなかった場合の処理
		if (array_empty(_datalist)) {
			// エラーアイテムを追加
			new BattleActBuilder("error").set_infomation("<color gray>Unknown", "<color red>EMPTY ERROR!!").build();
			_datalist = battle_act_get();
		}
		
		// dialoglistdataを取り出す
		for (var i = 0; i < array_length(_datalist); i++) {
			array_push(_dialogdatalist, _datalist[i].get_dialoglistdata());
		}
		
		battle_dialog_desc_update(_dialogdatalist[0].get_desc())
		
		for (var i = 0; i < array_length(_datalist); i++) {
			var _dialogdata = _dialogdatalist[i];
			new TypeWriterBuilder(30 + (i % 2) * 230, 375 + floor(i / 2) * 30, $"<skipped true>{_dialogdata.get_label()}")
				.set_font("normal")
				.set_scale(2, 2)
				.set_depth(DEPTH.UI_TEXT)
				.set_surface(obj_battle, battle_get_surface_varname())
				.enable_interaction(false)
				.enable_instance(true)
				.enable_choice(i)
				.set_tag("BattleDialogBoxSelect")
				.set_visible(i < 6)
				.build();
		}
		battle_dialog_set_list(_datalist);
		
		//リスト選択時の挙動function
		battle_set_nextfunc(_nextfunc)
		
		//選択変更時の挙動
		typewriter_choice_changed(function (_i) {
			battle_dialog_desc_update(obj_battle.dialog_list[_i].get_dialoglistdata().get_desc());
			
			//y座標を変更します
			var _list = typewriter_get_ext("BattleDialogBoxSelect");
			var _choice;
			var _len = array_length(_list);
			var _start = floor(_i / 6) * 6;
			//var _loopcount = min(_len - _start, 3);
			for (var i = 0; i < _len; i++) {
				_choice = _list[i].data.choice_id;
				_list[i].y = 375 + floor((_choice - _start) / 2) * 30;
				_list[i].data.visible = (_start == (floor(_choice / 6) * 6));
			}
		});
	}
}