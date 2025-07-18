surface_set_target(battle_get_surface());

//下部分
var _anim_y = 480 - in_anim*155;
draw_sprite_ext(spr_pixel, 0, 0, _anim_y, 640, _anim_y, 0, c_black, 1);
draw_sprite_ext(spr_pixel, 0, 0, _anim_y, 640, 2, 0, #332033, 1);

draw_sprite_ext(spr_pixel, 0, 0, _anim_y + 37, 640, _anim_y, 0, c_black, 1);
draw_sprite_ext(spr_pixel, 0, 0, _anim_y + 37, 640, 3, 0, #332033, 1);

//attack
if (battle_get_state() == BATTLE_STATE.MYTURN_ACTION){
	draw_sprite_ext(spr_pixel, 0, 79, 23, 224, 2, 0, c_navy, 1);
	draw_sprite_ext(spr_pixel, 0, 79, 441, 224, 2, 0, c_navy, 1);
}

//HP表示
if (battle_get_selectmode() == DIALOG_UI.SELECTENEMY){
	draw_set_font(fnt_8bit)
	draw_text_transformed(424, _anim_y + 39, "HP", 2, 1, 0)
	draw_text_transformed(524, _anim_y + 39, "MERCY", 2, 1, 0)
	var _enemy, _persent, _mercy;
	//3つまで表示するように
	var _len = array_length(battle_get_enemy_ids());
	var _start = floor(typewriter_choice_get_id() / 3) * 3;
	var _loopcount = min(_len - _start, 3);
	for (var i = 0; i < _loopcount; i++) {
		_enemy = battle_get_enemy_ids()[_start + i].data;
		//hp
		_persent = clamp(_enemy.get_hp() / _enemy.get_maxhp(), 0, 1)
		draw_sprite_ext(spr_pixel, 0, 420, _anim_y + 55 + 30 * i, 81, 16, 0, c_maroon, 1)
		draw_sprite_ext(spr_pixel, 0, 420, _anim_y + 55 + 30 * i, 81 * _persent, 16, 0, c_lime, 1)
		draw_set_color(c_white)
		draw_text_transformed(424, _anim_y + 55 + 30 * i, $"{ceil(_persent * 100)}%", 2, 1, 0)
		//mercy
		_mercy = _enemy.get_mercy();
		draw_sprite_ext(spr_pixel, 0, 520, _anim_y + 55 + 30 * i, 81, 16, 0, #ff5020, 1)
		draw_sprite_ext(spr_pixel, 0, 520, _anim_y + 55 + 30 * i, 81 * clamp(_mercy / 100, 0, 1), 16, 0, c_yellow, 1)
		draw_set_color(c_maroon)
		draw_text_transformed(524, _anim_y + 55 + 30 * i, $"{floor(_mercy)}%", 2, 1, 0)
	}
	if ((_len - _start) > 3){
		draw_sprite(spr_battle_dialog_arrow, 0, 614, 445)
	}
	if ((_start) > 2){
		draw_sprite_ext(spr_battle_dialog_arrow, 0, 614, 390, 1, -1, 0, c_white, 1)
	}
}

if (battle_get_selectmode() == DIALOG_UI.LIST){
	var _len = array_length(typewriter_get_ext("BattleDialogBoxSelect"));
	var _start = floor(typewriter_choice_get_id() / 6) * 6;
	if ((_len - _start) > 6){
		draw_sprite(spr_battle_dialog_arrow, 0, 470, 445)
	}
	if ((_start) > 5){
		draw_sprite_ext(spr_battle_dialog_arrow, 0, 470, 390, 1, -1, 0, c_white, 1)
	}
}

var _list = team_get(),
	_count = array_length(_list),
	_charturn = battle_get_charturn(),
	_ctanim,
	_x, _y, _color;
for(var i=0;i<_count;i++){
	_ctanim = charturn_anim[i];
	//if (((_count - 1) % 2) == 0){
	if (_count == 1){
		_x = 320;
	}else if (_count == 2){
		_x = 320 - 105 + i * 214;
	}else{
		_x = 320 - 213 + (i - show_target) * 213;
	}
	_y = _anim_y + 9 - _ctanim * (button_height + 2);
	draw_sprite_ext(spr_pixel, 0, _x - 105, _y - 7, 209, (2 + button_height) * _ctanim, 0, c_black, 1);
	if (_charturn == i){
		_y = _anim_y - 23;
		_color = _list[i].get_color();
		
		//UIライン
		for(var j=0;j<array_length(moveline);j++){
			moveline[j].draw(_x, _y+60, _color, _ctanim * button_height);
		}
		
		//ボタン
		var _btselect = battle_get_buttonselect(i),
			_buttons = battle_get_buttonlist(),
			_len = array_length(_buttons),
			_divx = ceil(_len * 35 / 2) - 1;
		
		for (var j = 0; j < _len; j++) {
			// (j == _btselect)はボタンが選択されているなら1 そうでなければ0
			draw_sprite(_buttons[j].get_sprite(), (j == _btselect), _x - _divx + j * 35, _y + 31);
		}
		
		_y = _anim_y + 9 - _ctanim * (button_height + 2);
		
		//////////////////////////
		//枠
		
		//Top
		draw_sprite_ext(spr_pixel, 0, _x - 107, _y - 9, 213, 2, 0, _color, 1);
		//Left
		draw_sprite_ext(spr_pixel, 0, _x - 107, _y - 7, 2, 35 + (2 + button_height) * _ctanim, 0, _color, 1);
		//Right
		draw_sprite_ext(spr_pixel, 0, _x + 104, _y - 7, 2, 35 + (2 + button_height) * _ctanim, 0, _color, 1);
		//Down
		draw_sprite_ext(spr_pixel, 0, _x - 105, _y + 28, 209, 2, 0, _color, 1);
		
	}else{
		if (_ctanim > 0){
			//Top
			draw_sprite_ext(spr_pixel, 0, _x - 107, _y - 9, 213, 2, 0, #332033, 1);
			//Left
			draw_sprite_ext(spr_pixel, 0, _x - 107, _y - 7, 2, 0 + (2 + button_height) * _ctanim, 0, #332033, 1);
			//Right
			draw_sprite_ext(spr_pixel, 0, _x + 104, _y - 7, 2, 0 + (2 + button_height) * _ctanim, 0, #332033, 1);
		}
	}
	//キャラUI
	draw_charbox(_x, _y, _list[i], charturn_icon_img[i]);
}

//テンションバー
_x = -30 + in_anim * 68;
_y = 40;
draw_sprite_ext(spr_tensionbar, 0, _x, _y, 1, 1, 0, c_white, 1)
var _w = sprite_get_width(spr_tensionfilling),
	_h = sprite_get_height(spr_tensionfilling),
	_c = [c_white, c_red, c_orange],
	_t;
for(var i=0;i<3;i++){
	_t = _h * tension_anim[i] / 100 - (i != 0) * 2;
	draw_sprite_part_ext(spr_tensionfilling, 0, 0, _h - _t, _w, _t, _x, _y + _h - _t, 1, 1, _c[i], 1);
}
//tension text
draw_set_font(fnt_8bit);
draw_set_align(0);
draw_sprite_ext(spr_tension, 0, _x - 30, _y + 30, 1, 1, 0, c_white, 1);

surface_set_target(srf_tp_outline);

if (tension_view < 100){
	draw_text_transformed(_x - 30, 0, tension_view, 2, 2, 0);
	draw_text_transformed(_x - 25, 25, "%", 2, 2, 0);
}else{
	draw_set_color(c_yellow)
	draw_text_transformed(_x - 28, 0, "M", 2, 2, 0);
	draw_text_transformed(_x - 24, 20, "A", 2, 2, 0);
	draw_text_transformed(_x - 20, 40, "X", 2, 2, 0);
}

surface_reset_target();
var _outline = surface_get_outline(srf_tp_outline, 2, 2, , , 4)
draw_surface(_outline, 0, _y + 70);
surface_free(_outline);

draw_set_ca();
draw_text(20, 460, typewriter_choice_get_id())
surface_reset_target();