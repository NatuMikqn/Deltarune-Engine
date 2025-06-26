function player_damage(_value){
	var _inst = instance_create_depth(obj_char_player.x, obj_char_player.y, -999, obj_damage_message);
	_inst.text = _value;
	_inst.color = c_aqua;
	_inst.target_surface = battle_get_surface();
	global.team_list[0].hp -= _value;
}