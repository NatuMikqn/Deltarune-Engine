alphafix(true);

#region background

surface_set_target(surface);

draw_sprite_ext(spr_saveselect_bg, 0, 0, bg_y, 2, 2, 0, c_white, 1);

// 背景のアニメ部分
draw_sprite_ext(spr_saveselect_bg_anim, floor(anim_image), 0, 520 + bg_y, 2, 2, 0, c_white, 1);
// 補間部分
if (anim_image % 1 >= 0.5) {
	draw_sprite_ext(spr_saveselect_bg_anim, floor(anim_image + 1), 0, 520 + bg_y, 2, 2, 0, c_white, 0.5);
}

surface_reset_target();

// 背景の上側の揺れ
var _tex_size = surface_get_texel_size(surface);
shader_sinwave_ss_setup(get_worldtimer(), 360 + bg_y, -2.0, 15, _tex_size.x, _tex_size.y);
draw_surface(surface, 0, 0);
shader_sinwave_ss_setup(get_worldtimer(), 360 + bg_y, -2.0, -15, _tex_size.x, _tex_size.y);
draw_surface_ext(surface, 0, 0, 1, 1, 0, c_white, 0.4);
shader_reset();

draw_sprite_ext(spr_pixel, 0, 0, 0, 640, 480, 0, c_black, 0.3);

#endregion

draw_set_font(fnt_8bit);
draw_set_colour(select_color);
draw_text_transformed_shadow(16, 8, $"CHAPTER {GAME_CHAPTER}", 2, 2, 0);

draw_text_transformed_shadow(80, 60, l10n_get_text("saveselect.selectfile"), 2, 2, 0);

draw_set_colour(default_color);

for (var i = 0; i < 3; i++) {
	draw_savefile(106, 106 + i * 90, "Natumi", "area.unknown", 99999999);
}

draw_text_transformed_shadow(108, 380, l10n_get_text("saveselect.copy"), 2, 2, 0);
draw_text_transformed_shadow(280, 380, l10n_get_text("saveselect.erase"), 2, 2, 0);
draw_text_transformed_shadow(408, 380, l10n_get_text("saveselect.chselect"), 2, 2, 0);
if (GAME_CHAPTER > 1) {
	draw_text_transformed_shadow(108, 420, l10n_get_text("saveselect.chfile", [GAME_CHAPTER - 1]), 2, 2, 0);
}
draw_text_transformed_shadow(280, 420, l10n_get_text("saveselect.language"), 2, 2, 0);
draw_text_transformed_shadow(408, 420, l10n_get_text("saveselect.endgame"), 2, 2, 0);


alphafix(false);
