if (movable) {
	if (is_controllable) {
		controlling_process();
	} else {
		motion_process();
	}
	
	anim_process(is_moved);
	
	with(obj_char_actor) {
		if (encounter_id != -1 && point_in_circle(other.x, other.y, x, y, encounter_circle_hitbox)){
			//encounter_start(encounter_id, id)
			break;
		}
	}
} else {
	anim_reset();
}