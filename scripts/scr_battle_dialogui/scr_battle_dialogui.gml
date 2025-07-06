enum DIALOG_UI
{
	MESSAGE,
	SELECTENEMY,
	LIST
}
enum LIST_TYPE
{
	MESSAGE,
	SELECTENEMY,
	LIST
}

///ダイアログを表示
function battle_dialog_message()
{
	with (obj_battle){
		typewriter_delete("BattleDialogBoxSelect")
		buttonmode = true;
		battle_show_enemyhp(false);
		battle_show_dialog(false);
	}
}
///敵指定
function battle_dialog_enemyselect(_func)
{
	with (obj_battle){
		typewriter_delete("BattleDialogBoxMessage");
		typewriter_delete("BattleDialogBoxSelect");
		buttonmode = false;
		battle_show_enemyhp(true);
	}
}
///敵指定
function battle_dialog_list()
{
	with (obj_battle){
		typewriter_delete("BattleDialogBoxMessage");
		typewriter_delete("BattleDialogBoxSelect");
		buttonmode = false;
		battle_show_enemyhp(false);
	}
}

///次UIの指定
///@arg {Real} type DIALOG_UI.?
function battle_set_dialog_next(_type)
{
	with (obj_battle){
		dialognext = _type;
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