var _len = array_length(list);
array_copy(list_previous, 0, list, 0, _len);
var _config;
for(var i=0;i<_len;i++){
	_config = config[type, i]
		if is_array(_config){
		var _true = false;
		for(var j=0;j<array_length(_config);j++){
				if (input_check_system(_config[j])){
				list[i]++;
				_true = true;
				break;
			}
		}
		if (!_true) list[i] = 0;
	}else{
		if (input_check_system(_config)){
			list[i] ++;
		}else{
			list[i] = 0;
		}
	}
}

if (type == INPUT_TYPE.GAMEPAD){
	if (!gamepad_is_connected(device)){
		if (keyboard_check_pressed(vk_space)){
			input_type(INPUT_TYPE.KEYBOARD)
		}
		if (keyboard_check_pressed(vk_right)){
			device = min(device + 1, 3)
		}
		if (keyboard_check_pressed(vk_left)){
			device = max(device - 1, 0)
		}
	}
}
