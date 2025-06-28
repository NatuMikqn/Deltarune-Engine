///@desc 色にして返します
///@arg {String|Constant.Color|Real|Array} value
///@return {Array<Constant.Color>}
function color_converter(value){
	if (is_string(value)){
		switch (string_lower(value)) {
			case "red":
				return array_create(4, c_red);
			case "yellow":
				return array_create(4, c_yellow);
			case "lime":
				return array_create(4, c_lime);
			case "fuchsia":
				return array_create(4, c_fuchsia);
			case "white":
				return array_create(4, c_white);
			case "black":
				return array_create(4, c_black);
		}
	}
	if (is_string(value)){
		if (string_copy(value, 1, 2) == "0x"){
			return array_create(4, real(value));
		}
		else if (string_char_at(value, 1) == "#"){
			var _rgb = [];
			_rgb[0] = string_copy(value, 2, 2);
			_rgb[1] = string_copy(value, 4, 2);
			_rgb[2] = string_copy(value, 6, 2);
			return array_create(4, real($"0x{_rgb[2]}{_rgb[1]}{_rgb[0]}"));
		}
		
	}
	if (is_real(value)){
		return array_create(4, value);
	}
	if (is_array(value)){
		return value;
	}
	show_debug_message($"Converter Error! - {value}")
	return array_create(4, c_white);
}