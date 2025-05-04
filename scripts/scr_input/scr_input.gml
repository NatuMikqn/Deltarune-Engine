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

///@ignore
function input_init(){
	global.input_list = [];
	global.input_list_previous = [];
	global.input_config = [];
	global.input_setting = {
		delay : 20,
		interval : 2
	};
}

///@arg {Real} target
///@arg {Constant.VirtualKey,Real,Array} key
function input_config(_target, _key){
	global.input_config[_target] = _key;
}

///@ignore
function input_endsetup(){
	var _count = array_length(global.input_config)
	global.input_list = array_create(_count,0);
	global.input_list_previous = array_create(_count,0);
}

///@ignore
function input_step(){
	var _len = array_length(global.input_list);
    array_copy(global.input_list_previous, 0, global.input_list, 0, _len);
	var _config
	for(var i=0;i<_len;i++){
		_config = global.input_config[i]
		if is_array(_config){
			var _true = false
			for(var j=0;j<array_length(_config);j++){
				if keyboard_check(_config[j]){
					global.input_list[i]++;
					_true = true;
					break;
				}
			}
			if (!_true) global.input_list[i] = 0;
		}else{
			if keyboard_check(_config){
				global.input_list[i] ++;
			}else{
				global.input_list[i] = 0;
			}
		}
	}
}

///@arg {real} key
///@return {bool}
function input_check_interval(_key){
	var _if, _time, _setting = global.input_setting
	_time = global.input_list[_key]
	_if = ((_time == 1) || (_time >= _setting.delay && ((_time - _setting.delay) % _setting.interval == 0)))
	return _if;
}

///@arg {real} key
///@return {bool}
function input_check(_key){
	var _if, _time
	_time = global.input_list[_key]
	_if = (_time >= 1)
	return _if;
}

///@arg {real} key
///@return {bool}
function input_check_pressed(_key){
	var _if, _time
	_time = global.input_list[_key]
	_if = (_time == 1)
	return _if;
}

///@arg {real} key
///@return {bool}
function input_check_released(_key){
	var _if, _time, _prevtime
	_time = global.input_list[_key]
	_prevtime = global.input_list_previous[_key]
	_if = (_time < _prevtime)
	return _if;
}