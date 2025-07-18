enum BATTLE_STATE
{
	START_ANIM,
	MYTURN,
	MYTURN_ACTION,
	ENEMY_TALK,
	ENEMY_IN,
	ENEMY,
	ENEMY_END,
}
enum BATTLE_TEAM_ANIM
{
	ENCOUNTER,
	SETUP,
	IDLE,
	FIGHT,
	DEFEND
}
enum BATTLE_ANIM_LOOP
{
	ONLY,
	LOOP,
	NONE
}
enum BATTLE_CHAR_ACTION
{
	FIGHT,
	ACT,
	ITEM,
	SPARE,
	DEFEND
}

///次のキャラクターにボタン操作を移します
///次のキャラクターがいなければ敵のターンに入ります
///@arg {Real} type icon
///@arg {Real} ct change tension
function battle_next_char(_type, _ct = 0)
{
	with (obj_battle){
		battle_tension_add(_ct, true);
		charaction[charturn] = _type;
		obj_battle_ui.charturn_icon_img[charturn] = battle_get_charicon(_type);
		charturn++
		with(obj_battle_ui) event_user(1);
		if (charturn >= array_length(team_get())){
			battle_tension_clear_history();
			battle_dialog_cleanup();
			battle_set_selectmode(DIALOG_UI.MESSAGE);
			battle_set_state(BATTLE_STATE.ENEMY_TALK);
		}else{
			battle_set_buttonlist(charturn);
			battle_dialog_button();
		}
	}
}
function battle_prev_char()
{
	with (obj_battle){
		if charturn > 0{
			charturn--
			battle_set_buttonlist(charturn);
			battle_team_set_anim(battle_char_ids[charturn], BATTLE_TEAM_ANIM.IDLE, BATTLE_ANIM_LOOP.LOOP, 10)
			battle_tension_prev()
			obj_battle_ui.charturn_icon_img[charturn] = 0
			with(obj_battle_ui) event_user(1)
		}
	}
}

///@arg {real} state
///@arg {real} timer
function battle_set_nextstate(_state, _real)
{
	obj_battle.next_state = _state;
	obj_battle.next_state_timer = _real;
}

///@return {real}
///@pure
function battle_get_state(){ return obj_battle.state; }

///@arg {Id.Instance} id
///@arg {real} anim
///@arg {real} loop
///@arg {real} animspd
function battle_team_set_anim(_id, _anim, _loop, _spd = 4)
{
	if instance_parent_equals(_id, obj_battle_team){
		with (_id){
			sprite_anim = _anim;
			sprite_loop = _loop;
			animtime = 0;
			animspd = _spd;
			subimg = 0;
		}
	}
}

function battle_get_surface()
{
	if (instance_exists(obj_battle) && surface_exists(obj_battle.srf_battle)){
		return obj_battle.srf_battle;
	}
	return -1;
}

function battle_get_surface_varname(){ return "srf_battle"; }

///ターンダイアログを設定します
///@arg {string} dialog
function battle_set_dialog(_dialog){ obj_battle.dialog = _dialog; }

///ターンダイアログを表示します
///@arg {bool} skipped
function battle_show_dialog(_skipped)
{
	with (obj_battle){
		if (!typewriter_exists("BattleDialogBoxMessage")){
			var _text = ""
			if (_skipped) _text += "<skipped true>"
			_text += $"<scale 2>{dialog}"
			new TypeWriterBuilder(30, 376, _text)
				.set_depth(DEPTH.UI - 1)
				.set_surface(obj_battle, battle_get_surface_varname())
				.enable_dialog(true)
				.enable_interaction(false)
				.set_tag("BattleDialogBoxMessage")
				.build();
		}
	}
}

///バトル中かどうか
///@return {bool}
function in_battle()
{
	return instance_exists(obj_battle)
}

///ターンを開始します
///@arg {Asset.GMObject} turn 複製したターンオブジェクト
///@return {Id.Instance} 作成されたターンのインスタンスID
function battle_turn_start(_trun)
{
	return instance_create_depth(0, 0, 0, _trun);
}

///ターンを終了します
///@arg {Asset.GMObject} turn 複製したターンオブジェクト
///@return {Id.Instance} 作成されたターンのインスタンスID
function battle_turn_end()
{
	battle_set_state(BATTLE_STATE.ENEMY_END);
	instance_destroy(obj_battle_turn);
	with(obj_battle_soul){
		show = false;
		hitbox = false;
		movable = false;
	}
}

///@arg {Real} char
///@return {Real}
function battle_get_buttonselect(_char) { return obj_battle.select_button[_char]; }

///@return {Real}
function battle_get_charturn() { return obj_battle.charturn; }

///@return {Array<Id.Instance>}
function battle_get_enemy_ids() { return obj_battle.battle_enemy_ids; }

function battle_act_add(_tag, _label, _desc, _tpcost) { return; }
function battle_act_remove(_tag) { return; }
function battle_get_current_act() { return; }
function battle_endmessage() { return; }