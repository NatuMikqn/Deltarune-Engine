list = [];
list_previous = [];
config = [];
type = INPUT_TYPE.KEYBOARD;
setting = {
	delay : 20,
	interval : 2
};
device = 0;

///@arg {Real|Constant.VirtualKey|Constant.GamepadButton|String} input
///@return {Bool}
function input_check_system(input){
	switch type{
		case INPUT_TYPE.KEYBOARD:
			return keyboard_check(input);
		case INPUT_TYPE.GAMEPAD:
			if (is_string(input)) {
				var _deadzone = 0.1;
				var _haxis = gamepad_axis_value(0, gp_axislh);
				var _vaxis = gamepad_axis_value(0, gp_axislv);
				var _distance = point_distance(0, 0, _haxis, _vaxis) > _deadzone;
				if (_distance){
					var _direction = point_direction(0, 0, _haxis, _vaxis);
					switch input{
						case "up": 
							return (in_range(_direction, 45, 135));
						case "left": 
							return (in_range(_direction, 135, 225));
						case "down": 
							return (in_range(_direction, 225, 315));
						case "right": 
							return (in_range(_direction, 315, 360) || in_range(_direction, 0, 45));
					}
				}
				return false;
			}else{
				return gamepad_button_check(0, input);
			}
	}
	return false;
}