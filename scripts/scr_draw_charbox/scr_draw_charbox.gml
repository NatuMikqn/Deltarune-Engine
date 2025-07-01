///キャラクター情報を基にcharboxを描画します
///@arg {real} x
///@arg {real} y
///@arg {Struct.CharacterInfoData} char
///@arg {real} img
function draw_charbox(_x, _y, _char, _img)
{
	var _iconsprite,
		_namesprite,
		_color
	
	_color = _char.get_color();
	
	_iconsprite = _char.get_charbox_iconsprite();
	_namesprite = _char.get_charbox_namesprite();
	
	var _count = array_length(team_get())
	var _hp = _char.get_hp(),
		_max = _char.get_maxhp()
	
	draw_charbox_custom(_x, _y, _iconsprite, _img, _namesprite, _color, _hp, _max)
}

///charboxを描画します
///@arg {real} x
///@arg {real} y
///@arg {Asset.GMSprite} icon_sprite
///@arg {real} char_img
///@arg {Asset.GMSprite} name_sprite
///@arg {real,Constant.Color} color
///@arg {real} hp
///@arg {real} hpmax
function draw_charbox_custom(_x, _y, _iconsprite, _img, _namesprite, _color, _hp, _max)
{
	//BackGround
	draw_sprite_ext(spr_pixel, 0, _x - 105, _y - 7, 209, 35, 0, c_black, 1);
	
	//Character Sprite & Name
	draw_sprite_ext(_iconsprite, _img, _x-94, _y+2, 1, 1, 0, c_white, 1);
	draw_sprite_ext(_namesprite, 0, _x-56, _y+5, 1, 1, 0, c_white, 1);
	
	//HPSprite
	draw_sprite_ext(spr_charbox_hp, 1, _x+3, _y+13, 1, 1, 0, c_white, 1);
	
	//HPText
	draw_set_font(global.hpfont);
	draw_set_align(2);
	
	//HP残量によってHPテキストの色を変える
	var _c = c_white;
	if (_hp <= 0) _c = c_red;
	else if (_max / _hp <= 0.25) _c = c_yellow;
	draw_set_color(_c);
	
	draw_text_transformed(_x+53, _y, _hp, 2, 2, 0);
	draw_sprite_ext(spr_charbox_slash, 1, _x+54, _y, 1, 1, 0, c_white, 1);
	draw_text_transformed(_x+98, _y, _max, 2, 2, 0);
	draw_set_color(c_white);
	
	//HPBar
	draw_sprite_ext(spr_pixel, 0, _x+21, _y+13, 76, 9, 0, c_maroon, 1);
	draw_sprite_ext(spr_pixel, 0, _x+21, _y+13, 76 * max(0, _hp / _max), 9, 0, _color, 1);
	
}