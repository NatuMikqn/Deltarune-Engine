///@arg {real} x
///@arg {real} y
///@arg {real} char_id
///@arg {real} img
function draw_charbox(_x, _y, _char, _img){
	var _charsprite,
		_namesprite,
		_color
	
	_color = team_get_flag(_char, TEAMCHAR_FLAG.COLOR)
	switch(_char){
		case TEAMCHAR.KRIS:
			_charsprite = spr_charbox_icon_kris
			_namesprite = l10n_get_assets(ASSET_TYPE.SPRITE, ASSETS_SPRITE.NAME_KRIS)
			break;
		case TEAMCHAR.SUSIE:
			_charsprite = spr_charbox_icon_susie
			_namesprite = l10n_get_assets(ASSET_TYPE.SPRITE, ASSETS_SPRITE.NAME_SUSIE)
			break;
		case TEAMCHAR.RALSEI:
			_charsprite = spr_charbox_icon_ralsei
			_namesprite = l10n_get_assets(ASSET_TYPE.SPRITE, ASSETS_SPRITE.NAME_RALSEI)
			break;
		case TEAMCHAR.NOELLE:
			_charsprite = spr_charbox_icon_noelle
			_namesprite = l10n_get_assets(ASSET_TYPE.SPRITE, ASSETS_SPRITE.NAME_NOELLE)
			break;
	}
	
	var _count = array_length(team_get())
	var _hp = team_get_flag(_char, TEAMCHAR_FLAG.HEALTH),
		_max = team_get_flag(_char, TEAMCHAR_FLAG.MAX_HEALTH)
	
	draw_charbox_custom(_x, _y, _charsprite, _img, _namesprite, _color, _hp, _max)
}

///@arg {real} x
///@arg {real} y
///@arg {Asset.GMSprite} char_sprite
///@arg {real} char_img
///@arg {Asset.GMSprite} name_sprite
///@arg {real,Constant.Color} color
///@arg {real} hp
///@arg {real} hpmax
function draw_charbox_custom(_x, _y, _charsprite, _img, _namesprite, _color, _hp, _max){
	draw_sprite_ext(spr_pixel, 0, _x - 105, _y - 7, 209, 35, 0, c_black, 1)
	
	draw_sprite_ext(_charsprite, _img, _x-94, _y+2, 1, 1, 0, c_white, 1)
	draw_sprite_ext(_namesprite, 0, _x-56, _y+5, 1, 1, 0, c_white, 1)

	draw_set_font(global.hpfont)
	draw_set_align(2)

	draw_sprite_ext(spr_charbox_hp, 1, _x+3, _y+13, 1, 1, 0, c_white, 1)
	draw_text_transformed(_x+53, _y, _hp, 2, 2, 0)
	draw_sprite_ext(spr_charbox_slash, 1, _x+54, _y, 1, 1, 0, c_white, 1)
	draw_text_transformed(_x+98, _y, _max, 2, 2, 0)
	
	draw_sprite_ext(spr_pixel, 0, _x+21, _y+13, 76, 9, 0, c_maroon, 1)
	draw_sprite_ext(spr_pixel, 0, _x+21, _y+13, 76 * (_hp / _max), 9, 0, _color, 1)
	
}