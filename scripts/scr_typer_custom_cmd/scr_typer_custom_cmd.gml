
///@arg {Struct.TypeWriterData} self
///@arg {Array} data
function typewriter_custom_cmd(_self, _data)
{
	with(_self){
		switch (_data[0]){
			case "color":
				color = color_converter(_data[1]);
				break;
			
			case "alpha":
				alpha = real(_data[1]);
				break;
			
			case "scale":
				if (array_length(_data) < 3){
					scale.set(real(_data[1]));
				}
				else{
					scale.set(real(_data[1]), real(_data[2]));
				}
				
				break;
			
			case "offset":
				offset.set(real(_data[1]), real(_data[2]));
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
				if (!skipped){
					sleep = real(_data[1]);
				}
				break;
			
			case "pause":
				pause();
				break;
			
			case "clear":
				pos.set(startpos);
				chars = [];
				break;
			
			case "interact":
			case "interaction":
				interaction = bool(_data[1]);
				break;
			
			case "skippable":
				skippable = bool(_data[1]);
				break;
			
			case "mtt":
				mtt_mode = bool(_data[1]);
				if (!mtt_mode) sleep_add();
				break;
		}
	}
}