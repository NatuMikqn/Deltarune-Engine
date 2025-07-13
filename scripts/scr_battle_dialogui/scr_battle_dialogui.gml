enum DIALOG_UI
{
	BUTTON,
	MESSAGE,
	SELECTENEMY,
	LIST
}

///ダイアログを表示
function battle_dialog_button()
{
	with (obj_battle){
		if (battle_get_selectmode() != DIALOG_UI.BUTTON) typewriter_delete("BattleDialogBoxMessage");
		typewriter_delete("BattleDialogBoxSelect");
		typewriter_delete("DialogDescription");
		typewriter_choice_changed();
		battle_set_selectmode(DIALOG_UI.BUTTON);
		battle_show_dialog(true);
	}
}
///敵指定モード
///@arg {Function} nextfunction
function battle_dialog_enemyselect(_nextfunc)
{
	var _enemy, _len;
	with (obj_battle){
		battle_dialog_cleanup();
		battle_set_selectmode(DIALOG_UI.SELECTENEMY);
		battle_set_nextfunc(_nextfunc);
		typewriter_choice_set_heartpos(-17, 18);
		
		_len = array_length(battle_enemy_ids);
		for (var i = 0; i < _len; i++) {
			_enemy = battle_enemy_ids[i].data;
			new TypeWriterBuilder(80, 375 + i * 30, $"<skipped true>{_enemy.get_name()}")
				.set_font("normal")
				.set_scale(2, 2)
				.set_depth(DEPTH.UI - 1)
				.set_surface(obj_battle, battle_get_surface_varname())
				.enable_interaction(false)
				.enable_instance(true)
				.enable_choice(i)
				.set_tag("BattleDialogBoxSelect")
				.set_visible(i < 3)
				.build();
		}
		typewriter_choice_changed(function (_i) {
			var _list = typewriter_get_ext("BattleDialogBoxSelect");
			
			for (var i = 0; i < array_length(_list); i++) {
				show_message(_list[i].data.choice_id)
				show_message(_list[i].x)
				show_message(_list[i].y)
			}
		});
	}
}
///リスト表示
///@arg {Array<Struct.BattleDialogList>} datalist
///@arg {Function} nextfunction
function battle_dialog_list(_datalist, _nextfunc = undefined)
{
	var _data;
	with (obj_battle){
		battle_dialog_cleanup();
		battle_set_selectmode(DIALOG_UI.LIST);
		typewriter_choice_set_heartpos(-12, 18);
		
		battle_dialog_list_update(_datalist[0].get_desc())
		
		for (var i = 0; i < array_length(_datalist); i++) {
			_data = _datalist[i];
			new TypeWriterBuilder(30 + (i % 2) * 230, 375 + floor(i / 2) * 30, $"<skipped true>{_data.get_label()}")
				.set_font("normal")
				.set_scale(2, 2)
				.set_depth(DEPTH.UI - 1)
				.set_surface(obj_battle, battle_get_surface_varname())
				.enable_interaction(false)
				.enable_instance(true)
				.enable_choice(i)
				.set_tag("BattleDialogBoxSelect")
				.build();
		}
		obj_battle.dialog_list = _datalist;
		battle_set_nextfunc(_nextfunc ?? function(){})
		typewriter_choice_changed(function (_i) {
			battle_dialog_list_update(obj_battle.dialog_list[_i].get_desc());
		});
	}
}
///リスト説明アップデート
///@arg {String} desc
function battle_dialog_list_update(_desc)
{
	with (obj_battle){
		typewriter_delete("DialogDescription");
		new TypeWriterBuilder(490, 375, $"<skipped true><color dkgray>{_desc}")
			.set_font("normal")
			.set_scale(2, 2)
			.set_depth(DEPTH.UI - 1)
			.set_surface(obj_battle, battle_get_surface_varname())
			.enable_interaction(false)
			.set_tag("DialogDescription")
			.build();
	}
}
///表示削除
function battle_dialog_cleanup()
{
	with (obj_battle){
		typewriter_delete("DialogDescription");
		typewriter_delete("BattleDialogBoxMessage");
		typewriter_delete("BattleDialogBoxSelect");
		typewriter_choice_changed();
	}
}

///@arg {Real} team
function battle_set_buttonlist(_team)
{
	obj_battle.buttonlist = team_get()[_team].get_buttonlist();
}
///@return {Array<Struct.ButtonInfo>}
function battle_get_buttonlist()
{
	return obj_battle.buttonlist;
}
///@arg {Real} pos
///@return {Struct.ButtonInfo}
function battle_get_buttondata(_pos)
{
	return obj_battle.buttonlist[_pos];
}
///@arg {Function} func
function battle_set_nextfunc(_func)
{
	obj_battle.nextfunc = _func;
}
///@return {Real}
function battle_get_selectmode()
{
	return obj_battle.selectmode;
}
///@arg {Real} mode DIALOG_UI.?
function battle_set_selectmode(_mode)
{
	obj_battle.selectmode = _mode;
}