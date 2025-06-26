if (type < 0){
	draw_set_ca(color, alpha);
	draw_set_font(global.dmgfont);
	draw_set_align(2);
	draw_text_transformed(x, y, text, width, height, 0);
	draw_set_ca(c_white, 1);
	draw_set_align(0);
}else{
	draw_sprite_ext(spr_font_battlemsg, type, x, y, width, height, 0, color, alpha)
}

