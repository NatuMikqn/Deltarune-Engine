enum AREA_STATE{
	NONE,
	AREA,
	INTERACTION,
	BATTLE
}
enum AREA_FACINGDIR{
	NONE,
	RIGHT,
	DOWN,
	LEFT,
	UP
}

///@ignore
function area_init(){
	global.area_state = AREA_STATE.NONE;
}

///オーバーワールドのステータスを指定
///@arg {real} state
function area_set_state(_state){
	global.area_state = _state;
}

///オーバーワールドのステータスを比較する
///@arg {real} state
///@return {bool}
///@pure
function area_state_equals(_state){
	return (global.area_state == _state);
}