event_inherited()

spr_index = {
	left	:	obj_char_enemy_test,
	right	:	obj_char_enemy_test,
	up		:	obj_char_enemy_test,
	down	:	obj_char_enemy_test
}

encounter_id = 0;
circle_hitbox = 32;

function motion_process() {
	var _input = {
			l : irandom(1),
			r : irandom(1),
			u : irandom(1),
			d : irandom(1),
		}

	hsp = (_input.r - _input.l) * move_speed
	vsp = (_input.d - _input.u) * move_speed
}