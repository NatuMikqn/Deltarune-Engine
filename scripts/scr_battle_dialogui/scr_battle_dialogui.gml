enum DIALOG_UI
{
	BUTTON,
	MESSAGE,
	SELECTTEAM,
	SELECTENEMY,
	LIST
}
enum FLAG_DCU //Flag Dialog CleanUp
{
	NOCLEAN_MES = 0x0001,
	RESET_FL = 0x0010,
}

/// ダイアログを表示
function battle_dialog_button()
{
	with (obj_battle){
		var _flag = 0;
		//UIがボタンの場合かつ、前がボタンであれば削除しない
		if (battle_get_selectmode() != DIALOG_UI.BUTTON) _flag = FLAG_DCU.RESET_FL | FLAG_DCU.NOCLEAN_MES;
		battle_dialog_cleanup(_flag);
		battle_set_selectmode(DIALOG_UI.BUTTON);
		battle_show_turndialog(true);
	}
}
/// リスト説明アップデート
/// @arg {String} desc
function battle_dialog_desc_update(_desc)
{
	with (obj_battle){
		typewriter_delete("DialogDescription");
		new TypeWriterBuilder(490, 375, $"<skipped true><color dkgray>{_desc}")
			.set_font("normal")
			.set_scale(2, 2)
			.set_depth(DEPTH.UI_TEXT)
			.set_surface(obj_battle, battle_get_surface_varname())
			.enable_interaction(false)
			.set_tag("DialogDescription")
			.build();
	}
}
///表示削除
///@arg {Real} Flag
function battle_dialog_cleanup(flag = 0)
{
	with (obj_battle){
		//全キャラクターのフラッシュを解除
		if (flag & FLAG_DCU.RESET_FL){
			if (instance_exists(team_select_target)) {
				team_select_target.flashpower = 0;
				team_select_target = noone;
			}
			if (instance_exists(enemy_select_target)) {
				enemy_select_target.flashpower = 0;
				enemy_select_target = noone;
			}
		}
		typewriter_delete("DialogDescription");
		typewriter_delete("BattleDialogBoxSelect");
		if (~flag & FLAG_DCU.NOCLEAN_MES) typewriter_delete("BattleDialogBoxMessage");
		typewriter_choice_changed();
		typewriter_choice_enable_reverse_v(true);
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
/// dialog操作時の次の行動を指定します
/// @arg {Function} func
function battle_set_nextfunc(_func)
{
	obj_battle.nextfunc = _func;
}

/// BattleDialogListをobj_battleに保存します
/// @arg {Function} dialog_list
function battle_dialog_set_list(_dialog_list)
{
	obj_battle.dialog_list = _dialog_list;
}
/// 選択中のBattleDialogListから、関数を取得します
/// 存在しない場合は空のfunctionが返されます
/// @return {Function}
function battle_dialog_get_nextfunc()
{
	var _data = obj_battle.dialog_list[typewriter_choice_get_id()];
	
	if (is_undefined(_data)) return function() {};
	
	return _data.get_func_select();
}
function battle_actionlist_clear()
{
	obj_battle.actionlist = [];
}
///@arg {Function} func
function battle_actionlist_push(_func)
{
	array_push(obj_battle.actionlist, _func);
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