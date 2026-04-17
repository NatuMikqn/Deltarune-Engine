if (enable_half_fps) {
	frameskip_prevtemp = obj_system.frameskip;
	
	// set half FPS
	obj_system.frameskip = (obj_system.frameskip + 1) * 2 - 1;
}
