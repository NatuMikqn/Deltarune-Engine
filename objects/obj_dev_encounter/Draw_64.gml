if (!instance_exists(obj_battle)){
	var _data, _id, _info, _check, _txt

	_info = {
		group : []
		
	}
	
	_id = encounter_get_id()
	_check = check_enemyid()
	
	draw_set_font(fnt_8bit)
	if (_check){
		_data = get_enemydata()
		_info.group = _data.get_enemy()
		
		array_foreach(_info.group, function (_e, _i){
				var _info = $"{_i}: {object_get_name(_e.object)}, x:{_e.x}, y:{_e.y}, depth:{_e.depth}";
				draw_text(0, (_i+2) * 16, _info)
			});
		
		draw_set_color(c_yellow)
		if (overworld_state_equals(OW_STATE.FIELD)){
			draw_text(0, (array_length(_info.group)+3) * 16, "Press F3 to start battle")
		}
	}else{
		_txt = ""
		_txt += "PAGEUP: GroupID-1\n"
		_txt += "PAGEDOWN: GroupID+1\n"
		_txt += "+SHIFT: *5"
		draw_text(0, (array_length(_info.group)+3) * 16, _txt)
	}
	draw_set_color(c_white)
	draw_text_transformed(0, 0, $"GroupID: {_id} - {_check ? "Exists" : "Non exists"}", 2, 2, 0)
}