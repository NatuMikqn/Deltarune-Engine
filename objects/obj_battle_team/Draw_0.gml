surface_set_target(battle_get_surface());

draw_sprite_ext(sprite ?? spr_missing, subimg, x, y, 2, 2, 0, c_white, 1);

surface_reset_target();