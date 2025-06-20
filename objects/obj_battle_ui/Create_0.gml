depth = DEPTH.UI

in_anim = 0;

charturn_prev = 0;
charturn_anim = array_create(team_get_count(), 0);
charturn_icon_img = array_create(team_get_count(), 0);

show_target = 0;
tension_view = 0;
tension_anim = [0, 0, 0]; //white, red, orange

moveline = []
timer = 0;

button_height = 30;

function MoveLine() constructor{
	pos = 0;
	hsp = 0;
	alpha = 1;
	static step = function(){
		hsp += 0.007
		pos += hsp
		alpha -= 0.01
	}
	static draw = function(_x, _y, _c, _h){
		alphafix(true)
		draw_sprite_ext(spr_pixel, 0, _x - 106 + pos, _y - _h, 2, _h, 0, _c, alpha)
		draw_sprite_ext(spr_pixel, 0, _x + 104 - pos, _y - _h, 2, _h, 0, _c, alpha)
		alphafix(false)
	}
}
