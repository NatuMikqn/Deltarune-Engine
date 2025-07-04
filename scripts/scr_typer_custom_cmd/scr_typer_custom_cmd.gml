
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
				globalmode = typewriter_font_get(font).get_globalmode();
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
			
			case "anim":
				var _target = "";
				var _type = "";
				
				if (_data[1] == "create"){ _target = "create"; _type = TCANIM.CREATE; }
				else if (_data[1] == "step"){ _target = "charstep"; _type = TCANIM.STEP; }
				else if (_data[1] == "twstep"){ _target = "typerstep"; _type = TCANIM.STEP; }
				else break;
				
				if (array_length(_data) > 2){
					anim[$ _target] = typewriter_anim_get(_type, _data[2]);
					array_delete(_data, 0, 3);
					anim_arg[$ _target] = _data;
				}else{
					//cleanupFunction
					if (_target == "typerstep"){
						var _func = anim[$ _target];
						if (is_array(_func) && is_method(_func[1])){
							array_foreach(chars, method({func : _func[1]}, function (_e) {
								func(_e);
							}))
						}
					}
					anim[$ _target] = undefined;
					anim_arg[$ _target] = [];
				}
				
				break;
			case "a":
				
				break;
		}
	}
}