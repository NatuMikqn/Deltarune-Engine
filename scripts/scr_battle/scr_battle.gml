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
	FIGHT_SLASH,
	DEFEND,
	CUSTOM
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
enum BATTLE_AUTONEXT
{
	USER,
	DIALOG_END
}

///次のキャラクターにボタン操作を移します
///次のキャラクターがいなければ敵のターンに入ります
///第一引数には現在のキャラクターが選択したボタン
///第二引数には変動TP量
///@arg {Real} type icon
///@arg {Real} ct change tension
function battle_next_charturn(_type, _ct = 0)
{
	with (obj_battle){
		battle_tension_add(_ct, true);
		char_action[charturn] = _type;
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

///前のキャラクターにボタン操作を移します
///前のキャラクターがいない場合はなにもしません
function battle_prev_char()
{
	with (obj_battle){
		if (charturn > 0){
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
///@deprecated
function battle_set_nextstate(_state, _real)
{
	obj_battle.next_state = _state;
	obj_battle.next_state_timer = _real;
}

///@return {Real}
///@pure
function battle_get_state(){ return obj_battle.state; }

///@arg {Id.Instance} id Instance ID
///@arg {Asset.GMSprite|Real} anim Animation ID or Sprite Asset
///@arg {Real} loop LoopType <BATTLE_ANIM_LOOP.?>
///@arg {Real} animspd Animation Speed
function battle_team_set_anim(_id, _anim, _loop, _spd = 4)
{
	if (instance_parent_equals(_id, obj_battle_team)){
		with (_id){
			if (is_int64(_anim)) {
				sprite = sprite_list[_anim];
			}
			else if (asset_get_type(_anim) == asset_sprite) {
				sprite = _anim;
			}
			sprite_loop = _loop;
			animtime = 0;
			animspd = _spd;
			subimg = 0;
		}
	}
}

///戦闘画面のバトルサーファスを返します
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
function battle_show_turndialog(_skipped)
{
	with (obj_battle){
		if (!typewriter_exists("BattleDialogBoxMessage")){
			var _text = ""
			if (_skipped) _text += "<skipped true>"
			_text += $"<scale 2>{dialog}"
			new TypeWriterBuilder(30, 376, _text)
				.set_depth(DEPTH.UI_TEXT)
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

///@ignore
function BattleAct() constructor
{
	tag = "";
	label = "";
	desc = "";
	tpcost = 0;
	func_select = undefined;
	data_action = undefined;
}

///@arg {String} tag
///@return {Struct.BattleActBuilder}
function BattleActBuilder(_tag) : BattleAct() constructor
{
	tag = _tag;
	
	///@arg {String} label
	///@arg {String} desc
	///@return {Struct.BattleActBuilder}
	static set_infomation = function(_label, _desc) {
		label = _label;
		desc = _desc;
		return self;
	}
	
	///@arg {Real} cost TP cost
	///@return {Struct.BattleActBuilder}
	static set_cost = function(_cost) {
		tpcost = _cost;
		return self;
	}
	
	///function (actor_position, target_position)
	///position : Struct.Vector2
	///@arg {Function} func
	///@return {Struct.BattleActBuilder}
	static set_func_select = function(_func) {
		func_select = _func;
		return self;
	}
	
	///function (actor_position, target_position)
	///position : Struct.Vector2
	///@arg {Function} func
	///@return {Struct.BattleActBuilder}
	static set_action = function(_func) {
		data_action = _func;
		return self;
	}
	
	static build = function() {
		var _data = new BattleActData(self);
		with (obj_battle_action_manager) {
			array_push(actlist, _data);
		}
	}
}

///@arg {Struct.BattleActBuilder} builder
///@ignore
function BattleActData(_builder) : BattleAct() constructor
{
	send_builder_to_data(_builder);
	
	action_object = undefined;
	
	/// BattleDialogListを返す
	///@return {Struct.BattleDialogList}
	static get_dialoglistdata = function() {
		return new BattleDialogList(label, desc, func_select);
	}
	
	/// ReturnFunction
	/// 未登録ならundefinedを返す
	///@return {Any}
	static get_func_select = function() {
		return func_select;
	}
	
	static new_action = function() {
		action_object = new data_action();
	}
	
	static step_action = function() {
		action_object.step();
		//アクション終了時
		if (!battle_is_action()) {
			delete action_object;
		}
	}
	
}

///アクションを停止します
///例として、actionfunc内で使用できます
//TODO : 完成させる
function battle_act_end()
{
	with (obj_battle_action_manager) {
		is_action = false;
	}
}

///アクション中かどうか
///@return {Bool}
function battle_is_action()
{
	return obj_battle_action_manager.is_action;
}

///@arg {String} tag
function battle_act_remove(_tag)
{
	with (obj_battle_action_manager) {
		var _pos = array_find_index(actlist, method({_tag}, function (_e) {
			return (_e.tag == _tag);
		}));
		array_delete(actlist, _pos, 1);
	}
}
function battle_act_update()
{
	//データ更新
	with (obj_battle_action_manager) {
		event_user(0)
	}
}
function battle_act_get()
{
	return obj_battle_action_manager.actlist;
}
function battle_act_reset()
{
	obj_battle_action_manager.actlist = [];
}
function battle_get_current_act()
{
	
}
function battle_endmessage()
{
	
}
///@return {Any}
function battle_get_current_char()
{
	return team_get()[battle_get_charturn()];
}
///@arg {Real} timing BATTLE_AUTONEXT.
function battle_act_set_autonext(_timing)
{
	
}
///@return {Id.Instance}
function battle_get_targetenemy()
{
	return obj_battle.enemy_select_target;
}