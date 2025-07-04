var _e, _text, _data, _delete;

for (var i = 0; i < array_length(list); i++) {
	_delete = false;
	_e = list[i];
	with (_e){
		
		if (input_check_pressed(INPUT.CANCEL) || input_check(INPUT.MENU)) start_skip();
		
		if (input_check_pressed(INPUT.CONFIRM) || input_check(INPUT.MENU)){
			if (is_end() && interaction){
				_delete = true;
			}else{
				resume();
			}
			
		}
		
		while (can_read()){
			_text = get_textdata();
			while ((_text.type == "cmd") && can_read()) {
				_data = _text.data;
				
				if (_text.type == "cmd"){
					typewriter_custom_cmd(self, _data);
				}
				readstep++
				if (is_end()) break;
				_text = get_textdata();
			}
			
			if (can_read()){
				add_chars();
				sleep_add();
			}
			
			if (is_end()){
				pause();
				break;
			}
			
		}
		step();
	}
	
	if (_delete){
		array_delete(list, i, 1)
		i--
	}
	
}