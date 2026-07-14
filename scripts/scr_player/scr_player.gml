///ダメージを与えます
///負の値の場合は、回復する予定です
///@arg {Real} team_index
///@arg {Real} damagevalue
function player_damage(_team_index, _value){
	var _inst = instance_create_depth(obj_char_kris.x, obj_char_kris.y, -999, obj_damage_message);
	_inst.text = _value;
	_inst.color = team_get()[_team_index].get_color_second();
	_inst.target_surface = battle_get_surface();
	team_get()[_team_index].hp -= _value;
}