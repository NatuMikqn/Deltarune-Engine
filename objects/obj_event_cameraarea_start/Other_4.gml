with (obj_event_cameraarea_end) {
	
	if (event_id == other.event_id) {
		other.pair = id;
		break;
	}
}

if (is_undefined(pair)) {
	show_debug_message("[CameraArea] No pair")
}