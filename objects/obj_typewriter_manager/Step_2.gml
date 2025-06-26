var _e, _text, _data;

for (var i = 0; i < array_length(list); i++) {
	_e = list[i];
	with (_e){
		if (!is_sleep()){
			_text = get_textdata();
			while (_text.type == "cmd" || _text.type == "l10n"){
				_data = _text.data;
				
				if (_text.type == "cmd"){
					switch (_data[0]){
						case "color":
							color = _data[1];
							break;
						case "scale":
							scale = _data[1];
							break;
						case "alpha":
							alpha = _data[1];
							break;
						case "offset":
							offset = _data[1];
							break;
						case "font":
							font = _data[1];
							break;
						case "newline":
							newline()
							break;
						case "spd":
						case "speed":
							speed = real(_data[1]);
							break;
						case "sleep":
							sleep = real(_data[1]);
							break;
					}
				}
				
				if (_text.type == "l10n"){
					_e.l10n();
				}
				
				_text = _e.next_read();
			}
			
			_e.add_chars();
			
			sleep += speed;
		}
		
	}
	if (_e.is_end()){
		array_delete(list, i, 1);
		i--;
	}
	
	
}