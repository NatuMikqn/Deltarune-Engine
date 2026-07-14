alphafix(true);

surface_set_target(surface);

draw_sprite_ext(spr_saveselect_bg, 0, 0, bg_y, 2, 2, 0, c_white, 1);

// 背景のアニメ部分
draw_sprite_ext(spr_saveselect_bg_anim, floor(anim_image), 0, 520 + bg_y, 2, 2, 0, c_white, 1);

// 背景画像補間部分
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

alphafix(false);