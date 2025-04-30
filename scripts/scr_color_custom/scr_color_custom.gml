///@arg {real,string} c
///@return {Array<Constant.Color>}
function typer_get_color(_c){
	var _return = [c_fuchsia, c_black],
		_digits = string_digits(_c);
	
	if (_digits == ""){
		switch(_c){
			case "white":
			case "c_white":
				_return = [c_white, c_white];
				break;
			
			case "red":
			case "c_red":
				_return = [c_white, c_red];
				break;
			
			case "orange":
			case "c_orange":
				_return = [c_white, c_orange];
				break;
			
			case "yellow":
			case "c_yellow":
				_return = [c_white, c_yellow];
				break;
			
			case "lime":
			case "c_lime":
				_return = [c_white, c_lime];
				break;
			
			case "green":
			case "c_green":
				_return = [c_white, c_green];
				break;
			
			case "aqua":
			case "c_aqua":
				_return = [c_white, c_aqua];
				break;
			
			case "blue":
			case "c_blue":
				_return = [c_white, c_blue];
				break;
			
			case "purple":
			case "c_purple":
				_return = [c_white, c_purple];
				break;
			
			case "fuchsia":
			case "c_fuchsia":
				_return = [c_white, c_fuchsia];
				break;
			
		}
	}else{
		_c = team_get_flag(real(_digits), TEAMCHAR_FLAG.COLOR);
		if !is_undefined(_c){
			_return = [_c, _c];
		}
	}
	return _return;
}