surface_set_target(battle_get_surface());
shader_apply_tint(c_white, flashpower);
draw_self();
shader_reset();
surface_reset_target();