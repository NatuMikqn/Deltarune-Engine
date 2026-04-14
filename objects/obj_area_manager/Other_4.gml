with (obj_event_spawnpoint) {
	if (spawn_id == -1) {
		instance_create_depth(x, y, 0, obj_char_player);
		break;
	}
}