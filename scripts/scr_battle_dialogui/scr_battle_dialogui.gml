enum DIALOG_UI
{
	BUTTON,
	MESSAGE,
	SELECTENEMY,
	LIST
}
enum FLAG_DCU //Flag Dialog CleanUp
{
	NOCLEAN_MES = 0x0001,
	RESET_FL = 0x0010,
}

///ダイアログを表示
function battle_dialog_button()
{
	with (obj_battle){
		var _flag = 0;
		//UIがボタンの場合かつ、前がボタンであれば削除しない
		if (battle_get_selectmode() != DIALOG_UI.BUTTON) _flag = FLAG_DCU.RESET_FL | FLAG_DCU.NOCLEAN_MES;
		battle_dialog_cleanup(_flag);
		battle_set_selectmode(DIALOG_UI.BUTTON);
		battle_show_dialog(true);
	}
}
///敵指定モード
///@arg {Function} nextfunction
function battle_dialog_enemyselect(_nextfunc)
{
	var _enemy, _len, _ids = battle_get_enemy_ids();
	with (obj_battle){
		battle_dialog_cleanup();
		battle_set_selectmode(DIALOG_UI.SELECTENEMY);
		battle_set_nextfunc(_nextfunc);
		typewriter_choice_set_heartpos(-17, 18);
		
		obj_battle.enemy_target = _ids[0];
		
		_len = array_length(battle_get_enemy_ids());
		for (var i = 0; i < _len; i++) {
			_enemy = battle_get_enemy_ids()[i].data;
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
		typewriter_choice_changed(function (_i, _prev) {
			//敵のホワイトフラッシュ再適応
			var _ids = battle_get_enemy_ids();
			obj_battle.enemy_target = _ids[_i];
			
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
		
		if (array_empty(_datalist)) { _datalist[0] = new BattleDialogList("<color gray>Unknown", "<color red>EMPTY ERROR!!", function () {}); }
		
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
				.set_visible(i < 6)
				.build();
		}
		obj_battle.dialog_list = _datalist;
		battle_set_nextfunc(_nextfunc ?? function(){
			
		})
		typewriter_choice_changed(function (_i) {
			battle_dialog_list_update(obj_battle.dialog_list[_i].get_desc());
			
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
///@arg {Real} Flag
function battle_dialog_cleanup(flag = 0)
{
	with (obj_battle){
		if ((flag & FLAG_DCU.RESET_FL) && (instance_exists(enemy_target))){
			enemy_target.flashpower = 0;
			enemy_target = noone;
		}
		typewriter_delete("DialogDescription");
		typewriter_delete("BattleDialogBoxSelect");
		if (~flag & FLAG_DCU.NOCLEAN_MES) typewriter_delete("BattleDialogBoxMessage");
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