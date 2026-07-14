enum MENU_SELECT_STATE {
	LIST_SELECT,
	CHECK_LOAD
}

// メニュー操作状況
select_state = MENU_SELECT_STATE.LIST_SELECT;

// ListSelect
theme = instance_create_depth(0, 0, depth + 1, obj_menu_theme_ch1end);

default_color = theme.default_color;
select_color = theme.select_color;
plus_color = theme.plus_color;

if (audio_exists(theme.music)) {
	audio_play_sound(theme.music, 0, true);
}

fader_run(1, 0, 40);

select_index = [new Vector2()];

selecting = instance_create_depth(0, 0, 0, obj_selecting);
selecting.add_point(-999, 0, 0);
selecting.add_point(-999, 1, 1);
selecting.add_point(-999, 2, 2);
selecting.add_point(0, 3, 3);
selecting.add_point(1, 3, 4);
selecting.add_point(2, 3, 5);
if (GAME_CHAPTER > 1) {
	selecting.add_point(0, 4, 6);
}
selecting.add_point(1, 4, 7);
selecting.add_point(2, 4, 8);
selecting.finish_setup(0);

// CheckLoad
cl_select_saveid = -1;
cl_select = 0;


// functions

/// @arg {Real} id
function color_set_auto(_id) {
	draw_set_colour(default_color);
	if (selecting.now_id == _id) {
		draw_set_colour(select_color);
	}
}

/// @arg {Real} id
/// @arg {Real} x
/// @arg {Real} y
/// @arg {String} name
/// @arg {String} areaName
/// @arg {Real} time
function draw_savefile(_id, _x, _y, _name, _area, _time) {
	color_set_auto(_id);
	
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
	// time
	draw_text_transformed_shadow(_x + 268, _y + 14, gametime_to_dtime(_time), 2, 2, 0);
	
	if (select_state == MENU_SELECT_STATE.CHECK_LOAD && select_saveid == _id) {
		draw_set_colour(cl_select == 0 ? select_color : default_color);
		draw_text_transformed_shadow(_x + 74, _y + 48, l10n_get_text("saveselect.checkload.continue"), 2, 2, 0);
		draw_set_colour(cl_select == 1 ? select_color : default_color);
		draw_text_transformed_shadow(_x + 254, _y + 48, l10n_get_text("saveselect.checkload.back"), 2, 2, 0);
	} else {
		// area name
		draw_text_transformed_shadow(_x + 54, _y + 48, l10n_get_text(_area), 2, 2, 0);
	}
}

/// @arg {Real} id
/// @arg {Real} x
/// @arg {Real} y
/// @arg {String} text
function draw_menutext(_id, _x, _y, _text) {
	color_set_auto(_id);
	
	draw_text_transformed_shadow(_x, _y, _text, 2, 2, 0);
}