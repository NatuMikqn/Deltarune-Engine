if (enable_half_fps) {
	frameskip_prevtemp = frameskip_get();
	
	// set half drawFPS
	frameskip_set((frameskip_get() + 1) * 2 - 1);
}
