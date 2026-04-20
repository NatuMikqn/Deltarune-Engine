select = 0;
surface = -1;

default_color = merge_color(c_ltgray, c_navy, 0.2);
select_color = c_white;
plus_color = merge_color(c_yellow, c_white, 0.5);

audio_play_sound(mus_saveselect, 0, true);

fader_run(1, 0, 40);

bg_y = 0;
easing_run(id, "bg_y", 3, 1, 0, -40, 60);

anim_image = 0;

/// @arg {Real} x
/// @arg {Real} y
/// @arg {String} name
/// @arg {String} areaName
/// @arg {Real} time
function draw_savefile(_x, _y, _name, _area, _time) {
	var _color = draw_get_colour();
	draw_sprite_ext(spr_pixel, 0, _x + 4, _y + 4, 420, 78, 0, c_black, 0.5);
	// left
	draw_sprite_ext(spr_pixel, 0, _x, _y, 424, 4, 0, _color, 1);
	// top
	draw_sprite_ext(spr_pixel, 0, _x, _y + 4, 4, 82, 0, _color, 1);
	// right
	draw_sprite_ext(spr_pixel, 0, _x + 424, _y, 4, 82, 0, _color, 1);
	// bottom
	draw_sprite_ext(spr_pixel, 0, _x + 4, _y + 82, 424, 4, 0, _color, 1);
	
	// name
	draw_text_transformed_shadow(_x + 54, _y + 14, _name, 2, 2, 0);
	// area name
	draw_text_transformed_shadow(_x + 54, _y + 48, l10n_get_text(_area), 2, 2, 0);
	// time
	draw_text_transformed_shadow(_x + 268, _y + 14, gametime_to_dtime(_time), 2, 2, 0);
}