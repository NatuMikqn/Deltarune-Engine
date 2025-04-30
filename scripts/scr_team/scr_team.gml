enum TEAMCHAR{
	KRIS,
	SUSIE,
	RALSEI,
	NOELLE
}
enum TEAMCHAR_FLAG{
	HEALTH,
	MAX_HEALTH,
	COLOR,
	AREA_OBJ,
	BATTLE_OBJ,
	TECHABLE,
	
	ENCOUNTER_X,
	ENCOUNTER_Y,
	BATTLE_X,
	BATTLE_Y
}

function team_init(){
	global.char_data = [];
	global.team_list = [];
}

function team_custom(){
	team_join(TEAMCHAR.KRIS)
	team_join(TEAMCHAR.SUSIE)
	team_join(TEAMCHAR.RALSEI)
	team_join(TEAMCHAR.NOELLE)
	
	team_set_flag(TEAMCHAR.KRIS, TEAMCHAR_FLAG.HEALTH, 90)
	team_set_flag(TEAMCHAR.KRIS, TEAMCHAR_FLAG.MAX_HEALTH, 90)
	team_set_flag(TEAMCHAR.KRIS, TEAMCHAR_FLAG.COLOR, c_aqua)
	team_set_flag(TEAMCHAR.KRIS, TEAMCHAR_FLAG.AREA_OBJ, obj_char_player)
	team_set_flag(TEAMCHAR.KRIS, TEAMCHAR_FLAG.BATTLE_OBJ, obj_battle_team_kris)
	team_set_flag(TEAMCHAR.KRIS, TEAMCHAR_FLAG.TECHABLE, false)
	
	team_set_flag(TEAMCHAR.SUSIE, TEAMCHAR_FLAG.HEALTH, 110)
	team_set_flag(TEAMCHAR.SUSIE, TEAMCHAR_FLAG.MAX_HEALTH, 110)
	team_set_flag(TEAMCHAR.SUSIE, TEAMCHAR_FLAG.COLOR, c_fuchsia)
	team_set_flag(TEAMCHAR.SUSIE, TEAMCHAR_FLAG.AREA_OBJ, obj_char_player)
	team_set_flag(TEAMCHAR.SUSIE, TEAMCHAR_FLAG.BATTLE_OBJ, obj_battle_team_susie)
	team_set_flag(TEAMCHAR.SUSIE, TEAMCHAR_FLAG.TECHABLE, true)
	
	team_set_flag(TEAMCHAR.RALSEI, TEAMCHAR_FLAG.HEALTH, 70)
	team_set_flag(TEAMCHAR.RALSEI, TEAMCHAR_FLAG.MAX_HEALTH, 70)
	team_set_flag(TEAMCHAR.RALSEI, TEAMCHAR_FLAG.COLOR, c_lime)
	team_set_flag(TEAMCHAR.RALSEI, TEAMCHAR_FLAG.AREA_OBJ, obj_char_player)
	team_set_flag(TEAMCHAR.RALSEI, TEAMCHAR_FLAG.BATTLE_OBJ, obj_battle_team_ralsei)
	team_set_flag(TEAMCHAR.RALSEI, TEAMCHAR_FLAG.TECHABLE, true)
	
	team_set_flag(TEAMCHAR.NOELLE, TEAMCHAR_FLAG.HEALTH, 90)
	team_set_flag(TEAMCHAR.NOELLE, TEAMCHAR_FLAG.MAX_HEALTH, 90)
	team_set_flag(TEAMCHAR.NOELLE, TEAMCHAR_FLAG.COLOR, c_yellow)
	team_set_flag(TEAMCHAR.NOELLE, TEAMCHAR_FLAG.AREA_OBJ, obj_char_player)
	team_set_flag(TEAMCHAR.NOELLE, TEAMCHAR_FLAG.BATTLE_OBJ, obj_battle_team_noelle)
	team_set_flag(TEAMCHAR.NOELLE, TEAMCHAR_FLAG.TECHABLE, true)
}

///@arg {real} character
function team_join(_char_id){
	array_push(global.team_list, _char_id);
}

///@arg {bool} get_three
///@return {array}
function team_get(_three = false){
	if (_three){
		var _return = []
		array_copy(_return, 0, global.team_list, 0, min(3, array_length(global.team_list)))
		return _return;
	}else{
		return global.team_list;
	}
}

///@arg {bool} get_three
///@return {real}
function team_get_count(_three = true){
	return array_length(team_get());
}

function team_clear(){
	global.team_list = [];
}

///@arg {real} character
///@arg {real} flag
///@arg {any} value
function team_set_flag(_char, _flag, _val){
	global.char_data[_char][_flag] = _val
}

///@arg {real} character
///@arg {real} flag
///@arg {any} default
///@return {any}
function team_get_flag(_char, _flag, _def = undefined){
	
	if array_exists(global.char_data, _char){
		
		var _chardata = global.char_data[_char];
		
		if array_exists(_chardata, _flag){
			return global.char_data[_char][_flag];
		}else{
			return _def;
		}
	}else{
		return _def;
	}
}