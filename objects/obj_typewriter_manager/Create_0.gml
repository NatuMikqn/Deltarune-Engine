sx = 0;
sy = 0;
text = "";

xoffset = 0;
yoffset = 0;

font = fnt_8bit;
//ASCII外の代替フォント
secfont_enable = true;
secfont = fnt_jf14;
//一番背の高いフォント
tallest_font_height = -1;

xscale = 2;
yscale = 2;
shadow = false;
color = array_create(4, c_white);
shadow_color = array_create(4, #05057b);
alpha = 1;
anim = 0;

spd = 3;
//スキップ可能か
skippable = true;
gui = false;

//read-only
read = 0;
time = 0;
//停止中か
pause = false;
//スキップ中か
skipped = false;

cmd = [];

char_list = [];

space_char = [" ", "　"]

choice = 0;
func = undefined;

cmd_funcs = [];

///@arg {real} sx
///@arg {real} sy
///@arg {string} char
function CharCreate(_sx, _sy, _char) constructor{
	//初期設置位置
	sx = _sx;
	sy = _sy;
	//絶対位置
	mx = 0;
	my = 0;
	xscale = 1;
	yscale = 1;
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
	///@arg {real} x
	///@arg {real} y
	///@arg {real} alpha
	static draw = function(_x, _y, _alpha){
		var _v = vector2(_x + (sx + mx), _y + (sy + my));
		draw_set_font(font);
		draw_set_align(0);
		draw_text_transformed_color(_v.x+xscale/2, _v.y+yscale/2, char, xscale, yscale, 0, shadow_color[0], shadow_color[1], shadow_color[2], shadow_color[3], _alpha);
		draw_text_transformed_color(_v.x, _v.y, char, xscale, yscale, 0, color[0], color[1], color[2], color[3], _alpha);
	}
}