depth = -1000
sx = 0;
sy = 0;
text = "";
font = l10n_get_assets(ASSET_TYPE.FONT, ASSETS_FONT.DIALOG);
xscale = 2;
yscale = 2;
shadow = false;
color = array_create(4, c_white);
shadow_color = array_create(4, #05057b);
alpha = 1;

asterisk = false;
read = 0;
spd = 3;
time = 0;
pause = false;
skipped = false;
skippable = true;
battle_surface = false;
cmd = [];

char_list = [];

space_char = [" ", "　"]

choice = 0;
func = undefined;

///@arg {real} sx
///@arg {real} sy
///@arg {string} char
function CharCreate(_sx, _sy, _char) constructor{
	sx = _sx;
	sy = _sy;
	mx = 0;
	my = 0;
	char = _char;
	shadow = true;
	color = array_create(4, c_white);
	shadow_color = array_create(4, #05057b);
	anim = -1;
	font = -1;
	timer = 0;
	static step = function(){
		switch(anim){
			case 0:
				mx = chance(0.5) * (irandom(2)-1);
				my = chance(0.5) * (irandom(2)-1);
				break;
			case 1:
				mx = irandom(2)-1;
				my = irandom(2)-1;
				break;
			case 2:
				my = dsin(timer * 6) * 4;
				break;
			default:
				mx = 0;
				my = 0;
				break;
		}
		timer++
	}
	static draw = function(_x, _y, _xscale, _yscale, _alpha){
		var _v = vector2(_x + (sx + mx) * _xscale, _y + (sy + my) * _yscale);
		draw_set_font(font);
		draw_text_transformed_color(_v.x+_xscale/2, _v.y+_yscale/2, char, _xscale, _yscale, 0, shadow_color[0], shadow_color[1], shadow_color[2], shadow_color[3], _alpha);
		draw_text_transformed_color(_v.x, _v.y, char, _xscale, _yscale, 0, color[0], color[1], color[2], color[3], _alpha);
	}
}