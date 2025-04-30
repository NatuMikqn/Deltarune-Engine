enum BATTLE_STATE{
	START_ANIM,
	MYTURN,
	ATTACK,
	INTURN,
	ENEMYTURN,
	ENDTURN,
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
			instance_destroy(dialog_typer)
			battle_set_state(BATTLE_STATE.INTURN)
		}else{
			battle_show_dialog(true);
		}
	}
}
function battle_prev_char(){
	with (obj_battle){
		if charturn > 0{
			charturn--
			battle_team_set_anim(team_get_flag(charturn, TEAMCHAR_FLAG.BATTLE_OBJ), BATTLE_TEAM_ANIM.IDLE, BATTLE_ANIM_LOOP.LOOP, 10)
			battle_tension_sub(battle_tension_prev())
			obj_battle_ui.charturn_icon_img[charturn] = 0
			with(obj_battle_ui) event_user(1)
		}
	}
}
///@arg {real} state
function battle_set_state(_state){
	with (obj_battle){
		state = _state
		switch _state{
			case BATTLE_STATE.MYTURN:
				battle_show_dialog(false);
				event_user(0)
				with(obj_battle_ui){
					event_user(2)
					event_user(1)
				}
				
				break;
			case BATTLE_STATE.INTURN:
				with(obj_battle_board) event_user(0)
				delay_create(function(){ battle_set_state(BATTLE_STATE.ENEMYTURN) }, "", false, 30)
				break;
			case BATTLE_STATE.ENDTURN:
				with(obj_battle_board) event_user(1)
				delay_create(function(){ battle_set_state(BATTLE_STATE.MYTURN) }, "", false, 30)
				break;
		}
		
	}

}
///@return {real}
function battle_get_state(){
	return obj_battle.state;
}

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
		}
	}
}

function battle_get_surface(){
	if (instance_exists(obj_battle) && surface_exists(obj_battle.srf_battle)){
		return obj_battle.srf_battle;
	}
}

///@arg {string} dialog
function battle_set_dialog(_dialog){
	obj_battle.dialog = _dialog;
}

///@arg {bool} skipped
function battle_show_dialog(_skipped){
	with (obj_battle){
		if !instance_exists(dialog_typer){
			localization_set_group(L10N_GROUP.BATTLE)
			dialog_typer = typer_create(30, 376, get_text(dialog))
			dialog_typer.skipped = _skipped;
		}
	}
}

///@return {bool}
function in_battle(){
	return instance_exists(obj_battle)
}