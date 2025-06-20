var _e, _text, _data;

for (var i = 0; i < array_length(list); i++) {
	_e = list[i];
	_text = _e.get_textdata();
	while (_text.type == "cmd"){
		
		_data = _text.data;
		
		switch (_data[0]){
			case "color":
				_e.set_color(_data[1])
				break;
			case "scale":
				_e.set_scale(_data[1])
				break;
			case "alpha":
				_e.set_alpha(_data[1])
				break;
			case "offset":
				_e.set_offset(_data[1])
				break;
			case "font":
				_e.set_font(_data[1])
				break;
		}
		
		_text = _e.next_read();
	}
	audio_play_sound(snd_text, 0, 0)
}