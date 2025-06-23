if (show){
	surface_set_target(battle_get_surface());
	draw_sprite_ext(sprite, 0, round(x), round(y), xscale, yscale, angle, c_white, alpha);
	draw_text(x, y, $"{x}, {y}")
	surface_reset_target();
}