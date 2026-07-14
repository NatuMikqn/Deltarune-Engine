with (obj_event_spawnpoint) {
	if (spawn_id == -1) {
		other.player = instance_create_depth(x, y, 0, obj_char_kris);
		break;
	}
}
