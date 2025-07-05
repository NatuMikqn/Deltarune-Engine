enum BATTLE_STATE{
	START_ANIM,
	MYTURN,
	MYTURN_ACTION,
	ENEMY_TALK,
	ENEMY_IN,
	ENEMY,
	ENEMY_END,
}
enum BATTLE_TEAM_ANIM{
	ENCOUNTER,
	SETUP,
	IDLE,
	FIGHT,
	DEFEND
}
enum BATTLE_ANIM_LOOP{
	ONLY,
	LOOP,
	NONE
}
enum BUTTON{
	FIGHT = 0,
	ACT = 1,
	ITEM = 2,
	SPARE = 3,
	DEFEND = 4
}

///@arg {real} icon
function battle_next_char(_icon){
	with (obj_battle){
		obj_battle_ui.charturn_icon_img[charturn] = _icon
		charturn++
		with(obj_battle_ui) event_user(1)
		if charturn >= array_length(team_get()){
			battle_tension_clear_history()
			instance_destroy(dialogtext)
			battle_set_state(BATTLE_STATE.ENEMY_TALK)
		}else{
			battle_show_dialog(true);
		}
	}
}
function battle_prev_char(){
	with (obj_battle){
		if charturn > 0{
			charturn--
			battle_team_set_anim(battle_char_ids[charturn], BATTLE_TEAM_ANIM.IDLE, BATTLE_ANIM_LOOP.LOOP, 10)
			battle_tension_prev()
			obj_battle_ui.charturn_icon_img[charturn] = 0
			with(obj_battle_ui) event_user(1)
		}
	}
}

///@arg {real} state
///@arg {real} timer
function battle_set_nextstate(_state, _real){
	obj_battle.next_state = _state;
	obj_battle.next_state_timer = _real;
}

///@arg {real} state
function battle_set_state(_state){
	with (obj_battle){
		state = _state
		//ここでそれぞれの行動(変更時のみ)をここに入力
		switch _state{
			case BATTLE_STATE.MYTURN:
				if (team_get_count() == 0){
					battle_set_state(BATTLE_STATE.ENEMY_TALK)
				}else{
					battle_show_dialog(false);
					event_user(0)
					with(obj_battle_ui){
						event_user(2)
						event_user(1)
					}
				}
				
				break;
			
			case BATTLE_STATE.ENEMY_TALK:
				
				break;
			
			case BATTLE_STATE.ENEMY_IN:
				with(obj_battle_enemy) event_user(1);
				with(obj_battle_turn) event_user(1);
				if (instance_exists(obj_battle_turn)){
					with(obj_battle_board) event_user(0);
				}else{
					battle_set_state(BATTLE_STATE.MYTURN)
				}
				break;
			
			case BATTLE_STATE.ENEMY:
				with(obj_battle_turn) event_user(2);
				break;
			
			case BATTLE_STATE.ENEMY_END:
				with(obj_battle_turn) event_user(3);
				with(obj_battle_board) event_user(1);
				break;
		}
		
	}

}
///@return {real}
///@pure
function battle_get_state(){ return obj_battle.state; }

///@arg {Id.Instance} id
///@arg {real} anim
///@arg {real} loop
///@arg {real} animspd
function battle_team_set_anim(_id, _anim, _loop, _spd = 4){
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

function battle_get_surface(){
	if (instance_exists(obj_battle) && surface_exists(obj_battle.srf_battle)){
		return obj_battle.srf_battle;
	}
	return -1;
}

function battle_get_surface_varname(){
	return "srf_battle";
}

///ターンダイアログを設定します
///@arg {string} dialog
function battle_set_dialog(_dialog){ obj_battle.dialog = _dialog; }

///ターンダイアログを表示します
///@arg {bool} skipped
function battle_show_dialog(_skipped){
	with (obj_battle){
		if (!instance_exists(dialogtext)){
			dialogtext = new TypeWriterBuilder(30, 376, "<scale 2><interact false><skippable false>[battle.test.dialog.encounter]") 
				.set_depth(DEPTH.UI - 1)
				.set_surface(obj_battle, battle_get_surface_varname())
				.build();
		}
	}
}

///バトル中かどうか
///@return {bool}
function in_battle(){
	return instance_exists(obj_battle)
}

///ターンを開始します
///@arg {Asset.GMObject} turn 複製したターンオブジェクト
///@return {Id.Instance} 作成されたターンのインスタンスID
function battle_turn_start(_trun){
	return instance_create_depth(0, 0, 0, _trun);
}

///ターンを終了します
///@arg {Asset.GMObject} turn 複製したターンオブジェクト
///@return {Id.Instance} 作成されたターンのインスタンスID
function battle_turn_end(){
	battle_set_state(BATTLE_STATE.ENEMY_END);
	instance_destroy(obj_battle_turn);
	with(obj_battle_soul){
		show = false;
		hitbox = false;
		movable = false;
	}
}