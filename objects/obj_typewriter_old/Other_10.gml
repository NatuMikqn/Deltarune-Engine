///@desc CreateChar

var _char, _font

_char = string_char_at(text, read)

if (secfont_enable && !in_range(ord(_char), 32, 255)){
	_font = secfont
}else{
	_font = font
}

draw_set_font(_font)

if !array_contains(space_char, _char){
	var _c = new CharCreate(sx + xoffset, sy + yoffset, _char)
	_c.shadow = shadow
	_c.color = color
	_c.shadow_color = shadow_color
	_c.xscale = xscale;
	_c.yscale = yscale;
	_c.anim = anim;
	_c.font = _font
	
	var _height = string_height(" ")
	if (tallest_font_height < _height) tallest_font_height = _height
	
	array_push(char_list, _c)
	
	if (!skipped){
		audio_play_sound(snd_a, 0, 0)
	}
	sx += (string_width(_char) * xscale);
}else{
	sx += (string_width("A") * xscale)
}
