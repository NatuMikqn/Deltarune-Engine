event_inherited();
draw_set_font(l10n_get_font("default"));
draw_set_align(0);
draw_set_colour(c_white);

// 外見
draw_sprite_stretched(spr_pixel, 0, 62, 221, 517, 6);
draw_sprite_stretched(spr_pixel, 0, 270, 92, 6, 129);
draw_sprite_stretched(spr_pixel, 0, 323, 227, 6, 182);

draw_sprite_ext(spr_area_menu_captions_en, 0, 118, 86, 2, 2, 0, c_white, 1);
draw_sprite_ext(spr_area_menu_captions_en, 1, 376, 86, 2, 2, 0, c_white, 1);
draw_sprite_ext(spr_area_menu_captions_en, 2, 116, 216, 2, 2, 0, c_white, 1);
draw_sprite_ext(spr_area_menu_captions_en, 3, 372, 216, 2, 2, 0, c_white, 1);


// 
draw_text_transformed(365, 112, "BlackShard", 2, 2, 0);
draw_text_transformed(365, 142, "BlackShard", 2, 2, 0);
draw_text_transformed(365, 172, "BlackShard", 2, 2, 0);


// ステータス
// TODO: L10N適応
var _draw_x = 230;
draw_text_transformed(100, _draw_x, "Attack:", 2, 2, 0);
draw_text_transformed(230, _draw_x, "33", 2, 2, 0);

_draw_x += 27;
draw_text_transformed(100, _draw_x, "Defense:", 2, 2, 0);
draw_text_transformed(230, _draw_x, "33", 2, 2, 0);

_draw_x += 27;
draw_text_transformed(100, _draw_x, "Magic:", 2, 2, 0);
draw_text_transformed(230, _draw_x, "33", 2, 2, 0);

// アビリティ
_draw_x += 27;
draw_text_transformed(100, _draw_x, "", 2, 2, 0);

_draw_x += 27;
draw_text_transformed(100, _draw_x, "", 2, 2, 0);

_draw_x += 27;
draw_text_transformed(100, _draw_x, "", 2, 2, 0);

// 道具類
for (var i = 0; i < 6; i++) {
	draw_text_transformed(384, 230 + 27 * i, "FloweryScarf", 2, 2, 0);
}
