alphafix(true);
/// logo draw
surface_set_target(surface);
draw_sprite_ext(spr_logo, 0, 320, 240, 2, 2, 0, c_white, 1);
//draw_sprite_ext(spr_battle_button_item_ja, 0, 320, 240, 2, 2, 0, c_white, 1);
//draw_sprite_ext(spr_testshader, 0, 0, 0, 640 / 1024, 480 / 1024, 0, c_white, 1);
surface_reset_target();

if (step == 0) {
	var _texel = surface_get_texel_size(surface);
	var _wid = 60 * (1 - factor_effect);
	var _time = startwave + time * 2;
	repeat(3) {
		shader_sinwave_setup(_time, _wid, 40, 2, _texel.x, _texel.y);
		draw_surface_ext(surface, 0, 0, 1, 1, 0, c_white, factor_alpha * 0.66);
		_time += 20;
	}
	
	shader_reset();
}

if (step == 1) {
	draw_surface(surface, 0, 0);
}

if (step == 2) {
	
	draw_surface_ext(surface, 0, 0, 1, 1, 0, c_white, factor_alpha * factor_logoalpha);
	for (var i = 0; i < 10; i++) {
		for (var j = 0; j < 4; j++) {
			var _x = dsin(time + i * 24) * (i * factor_effect) * (1 - (j % 2) * 2);
			var _y = dcos(time + i * 24) * (i * factor_effect) * (1 - floor(j / 2) * 2);
			draw_surface_ext(surface, _x, _y, 1, 1, 0, c_white, factor_alpha * 0.14);
		}
	}
}

alphafix(false);

/*
shader_set(shd_sinwave);
shader_set_uniform_f(shader_get_uniform(shd_sinwave, "time"), time);
shader_set_uniform_f(shader_get_uniform(shd_sinwave, "frequency"), 0.1);
shader_set_uniform_f(shader_get_uniform(shd_sinwave, "power"), 0.05);
draw_surface(surface, 0, 0);
shader_reset();
*/