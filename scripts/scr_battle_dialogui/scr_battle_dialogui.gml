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
		if (selectmode == DIALOG_UI.BUTTON) typewriter_delete("BattleDialogBoxMessage");
		typewriter_delete("BattleDialogBoxSelect");
		selectmode = DIALOG_UI.BUTTON;
		battle_enable_enemyhp(false);
		battle_show_dialog(false);
	}
}
///敵指定モード
///@arg {Function} nextfunction
function battle_dialog_enemyselect(_nextfunc)
{
	var _enemy;
	with (obj_battle){
		typewriter_delete("BattleDialogBoxMessage");
		typewriter_delete("BattleDialogBoxSelect");
		selectmode = DIALOG_UI.SELECTENEMY;
		nextfunc = _nextfunc;
		battle_enable_enemyhp(true);
		
		for (var i = 0; i < array_length(battle_enemy_ids); i++) {
			_enemy = battle_enemy_ids[i].data;
			new TypeWriterBuilder(80, 375 + i * 30, $"<font normal><choice 0 {i}><skipped true>{_enemy.get_name()}")
				.set_font("normal")
				.set_scale(2, 2)
				.set_depth(DEPTH.UI - 1)
				.set_surface(obj_battle, battle_get_surface_varname())
				.set_interaction(false)
				.set_tag("BattleDialogBoxSelect")
				.build();
				
		}
	}
}
///リスト表示
function battle_dialog_list(_datalist)
{
	with (obj_battle){
		typewriter_delete("BattleDialogBoxMessage");
		typewriter_delete("BattleDialogBoxSelect");
		selectmode = DIALOG_UI.LIST;
		battle_enable_enemyhp(false);
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