/// @description Cmd

var _col
switch cmd[0]{
	case "nl":
	case "newline":
		event_user(1)
		break;
	case "sleep":
		time = real(cmd[1])
		break;
	case "c":
	case "color":
		_col = typer_get_color(cmd[1])
		color = [_col[0], _col[0], _col[1], _col[1]]
		break;
	case "color_rgb":
		_col = [real(cmd[1]), real(cmd[2]), real(cmd[3])]
		color = array_create(4, make_color_rgb(_col[0], _col[1], _col[2]))
		break;
	case "color_hash":
		var _bgr = $"{string_copy(cmd[1], 5, 2)}{string_copy(cmd[1], 3, 2)}{string_copy(cmd[1], 1, 2)}"
		_col = real("0x" + _bgr)
		color = array_create(4, _col)
		break;
	case "skipped":
		skipped = true;
		break;
	case "skippable":
		skippable = bool(cmd[1]);
		break;
	case "pause":
		skipped = false;
		pause = true;
		time = 0;
		break;
	case "clear":
		sx = 0;
		sy = 0;
		char_list = [];
		break;
	case "function":
	case "method":
	case "script":
		var _script = asset_get_index(cmd[1])
		if script_exists(_script){
			script_execute_ext(_script, cmd, 2)
		}
		break;
	case "font":
		
		break;
	case "*":
		asterisk = bool(cmd[1]);
		break;
}