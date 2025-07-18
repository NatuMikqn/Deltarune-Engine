surface_set_target(battle_get_surface());
shader_apply_tint(c_white, flashpower);
draw_sprite_ext(spr_battle_button_act, 0, x, y, 1, 1, 0, c_white, 1);
shader_reset();
surface_reset_target();