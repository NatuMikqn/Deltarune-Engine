enum INPUT{
	UP,
	DOWN,
	LEFT,
	RIGHT,
	CONFIRM,
	CANCEL,
	MENU,
	ANY
}
enum INPUT_TYPE{
	KEYBOARD,
	GAMEPAD
}


/// 入力タイプを変更します
///@arg {Real} type INPUT_TYPE.ANY
function input_type(type){
	obj_input_manager.type = type;
}

/// キーを登録します
/// gamepadのアナログスティックの向きを感知する場合は
/// "left" "right" "up" "down" のいずれかを入力してください
///@arg {Real} input INPUT.ANY
///@arg {Constant.VirtualKey|Constant.GamepadButton|Real|Array|String} key key
function input_config(input, key){
	obj_input_manager.config[obj_input_manager.type, input] = key;
}

///@ignore
function input_endsetup(){
	var _count = array_length(obj_input_manager.config[obj_input_manager.type])
	obj_input_manager.list = array_create(_count,0);
	obj_input_manager.list_previous = array_create(_count,0);
	
	input_type(INPUT_TYPE.KEYBOARD);
}

///@arg {real} key
///@return {bool}
function input_check_interval(key){
	var _if, _time, _setting = obj_input_manager.setting
	_time = obj_input_manager.list[key]
	_if = ((_time == 1) || (_time >= _setting.delay && ((_time - _setting.delay) % _setting.interval == 0)))
	return _if;
}

///@arg {real} key
///@return {bool}
function input_check(key){
	var _if, _time
	_time = obj_input_manager.list[key]
	_if = (_time >= 1)
	return _if;
}

///@arg {real} key
///@return {bool}
function input_check_pressed(key){
	var _if, _time
	_time = obj_input_manager.list[key]
	_if = (_time == 1)
	return _if;
}

///@arg {real} key
///@return {bool}
function input_check_released(key){
	var _if, _time, _prevtime
	_time = obj_input_manager.list[key]
	_prevtime = obj_input_manager.list_previous[key]
	_if = (_time < _prevtime)
	return _if;
}