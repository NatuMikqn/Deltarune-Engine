if (input_check_pressed(INPUT.DOWN)){
	var _names = struct_get_names(choice), _name, _data, _nexty, _next = choice[$ choicename].pos[1];
	for (var i = 0; i < array_length(_names); i++) {
		choicename = _names[i];
		if (choicename != _name){
			_data = choice[$_name];
			_nexty = _data.inst.y;
			if (_nexty > _next){
				
			}
		}
	}
}