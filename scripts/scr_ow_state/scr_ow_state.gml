enum OW_STATE{
	NONE,
	FIELD,
	BATTLE
}

///@ignore
function overworld_init(){
	global.overworld_state = OW_STATE.NONE;
}

///オーバーワールドのステータスを指定
///@arg {real} state
function overworld_set_state(_state){
	global.overworld_state = _state;
}

///オーバーワールドのステータスを比較する
///@arg {real} state
///@return {bool}
///@pure
function overworld_state_equals(_state){
	return (global.overworld_state == _state);
}