surface_set_target(obj_battle.srf_battle)

var _anim_y = 480 - in_anim*155
draw_sprite_ext(spr_pixel, 0, 0, _anim_y, 640, _anim_y, 0, c_black, 1)
draw_sprite_ext(spr_pixel, 0, 0, _anim_y, 640, 2, 0, #332033, 1)

draw_sprite_ext(spr_pixel, 0, 0, _anim_y + 37, 640, _anim_y, 0, c_black, 1)
draw_sprite_ext(spr_pixel, 0, 0, _anim_y + 37, 640, 3, 0, #332033, 1)

if (battle_get_state() == BATTLE_STATE.ATTACK){
	draw_sprite_ext(spr_pixel, 0, 79, 403, 224, 2, 0, c_navy, 1)
	draw_sprite_ext(spr_pixel, 0, 79, 441, 224, 2, 0, c_navy, 1)
}

var _list = team_get(),
	_count = array_length(_list),
	_charturn = obj_battle.charturn,
	_ctanim,
	_x, _y, _color
for(var i=0;i<_count;i++){
	_ctanim = charturn_anim[i]
	//if (((_count - 1) % 2) == 0){
	if (_count == 1){
		_x = 320
	}else if (_count == 2){
		_x = 320 - 105 + i * 214
	}else{
		_x = 320 - 213 + (i - show_target) * 213
	}
	/*if (((_count - 1) % 2) == 0){
		_x = 320 - 213 * floor(_count / 2) + i * 213
	}else{
		_x = 320 - 106 * floor(_count / 2) + i * 213
		//_x = 320 - 105 * floor(_count / 2) + i * 214
	}*/
	if (_charturn == i){
		_y = _anim_y - 23
		_color = team_get_flag(_list[i], TEAMCHAR_FLAG.COLOR)
		for(var j=0;j<array_length(moveline);j++){
			moveline[j].draw(_x, _y+30, _color)
		}
		var _btselect = obj_battle.select_list[i][0],
			_buttons = [
				l10n_get_assets(ASSET_TYPE.SPRITE, ASSETS_SPRITE.BUTTON_FIGHT),
				team_get_flag(_list[i], TEAMCHAR_FLAG.TECHABLE) ? l10n_get_assets(ASSET_TYPE.SPRITE, ASSETS_SPRITE.BUTTON_TECH) : l10n_get_assets(ASSET_TYPE.SPRITE, ASSETS_SPRITE.BUTTON_ACT),
				l10n_get_assets(ASSET_TYPE.SPRITE, ASSETS_SPRITE.BUTTON_ITEM),
				l10n_get_assets(ASSET_TYPE.SPRITE, ASSETS_SPRITE.BUTTON_SPARE),
				l10n_get_assets(ASSET_TYPE.SPRITE, ASSETS_SPRITE.BUTTON_DEFEND)
			]
		for(var j=0;j<5;j++){
			draw_sprite(_buttons[j], (j == _btselect), _x - 87 + j * 35, _y + 31)
		}
		_y = _anim_y + 9 - _ctanim * 32
		
		draw_sprite_ext(spr_pixel, 0, _x - 107, _y - 9, 213, 2, 0, _color, 1)
		draw_sprite_ext(spr_pixel, 0, _x - 107, _y - 7, 2, 35 + 32 * _ctanim, 0, _color, 1)
		draw_sprite_ext(spr_pixel, 0, _x + 104, _y - 7, 2, 35 + 32 * _ctanim, 0, _color, 1)
		draw_sprite_ext(spr_pixel, 0, _x - 105, _y + 28, 209, 2, 0, _color, 1)
		
	}
	_y = _anim_y + 9 - _ctanim * 32
	draw_charbox(_x, _y, _list[i], charturn_icon_img[i])
}

_x = -30 + in_anim * 68
_y = 40
draw_sprite_ext(spr_tensionbar, 0, _x, _y, 1, 1, 0, c_white, 1)
var _w = sprite_get_width(spr_tensionfilling),
	_h = sprite_get_height(spr_tensionfilling),
	_c = [c_white, c_red, c_orange],
	_t
for(var i=0;i<3;i++){
	_t = _h * tension_anim[i] / 100 - (i != 0) * 2
	draw_sprite_part_ext(spr_tensionfilling, 0, 0, _h - _t, _w, _t, _x, _y + _h - _t, 1, 1, _c[i], 1)
}
draw_set_font(fnt_8bit)
draw_set_align(0)
draw_sprite_ext(spr_tension, 0, _x - 30, _y + 30, 1, 1, 0, c_white, 1)
if (tension_view < 100){
	draw_text_transformed(_x - 30, _y + 70, tension_view, 2, 2, 0)
	draw_text_transformed(_x - 25, _y + 95, "%", 2, 2, 0)
}else{
	draw_set_color(c_yellow)
	draw_text_transformed(_x - 28, _y + 70, "M", 2, 2, 0)
	draw_text_transformed(_x - 24, _y + 90, "A", 2, 2, 0)
	draw_text_transformed(_x - 20, _y + 110, "X", 2, 2, 0)
}
for(var i=0;i<24;i++){
	//draw_charbox_custom(irandom(640), irandom(480), spr_charbox_icon_kris, spr_charbox_name_kris, irandom(16777215), irandom(100), irandom_range(80,120))
}
draw_set_ca()
surface_reset_target()