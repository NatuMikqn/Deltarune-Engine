if (input_check_pressed(INPUT.CONFIRM)){
	if (pause) pause = false;
	if (read >= string_length(text)) instance_destroy();
}else
if (!pause && skippable && input_check_pressed(INPUT.CANCEL)){
	skipped = true;
}

while (!pause) && (time <= 0 || (skipped)) && (read < string_length(text)){
	read++
	var _char = string_char_at(text, read),
		_cmdarg;
	//コマンドライン
	while (!pause && (_char == "<" || _char == "&")){
		if (_char == "<"){
			read++
			cmd = [""];
			_char = string_char_at(text, read);
			_cmdarg = 0;
			while (_char != ">"){
				if (_char == " "){
					_cmdarg++
					cmd[_cmdarg] = "";
				}else{
					cmd[_cmdarg] += _char;
				}
				read++
				_char = string_char_at(text, read);
			}
			event_user(2);
			if (pause || (!skipped && time > 0)){
				break;
			}
		}else
		if (_char == "&"){
			event_user(1);
		}
		read++
		_char = string_char_at(text, read);
	}
	if (pause || (!skipped && time > 0)){
		break;
	}
	event_user(0);
	time += spd;
}
if (!pause){
	time--
}

for(var i=0;i<array_length(char_list);i++){
	char_list[i].step();
}