///@desc CreateChar

draw_set_font(font)
var _char = string_char_at(text, read)

if !array_contains(space_char, _char){
	var _c = new CharCreate(sx, sy, _char)
	_c.shadow = shadow
	_c.color = color
	_c.shadow_color = shadow_color
	_c.font = font
	
	array_push(char_list, _c)
	
	if (!skipped){
		audio_play_sound(snd_text, 0, 0)
	}
	sx += string_width(_char) + 1;
}else{
	sx += string_width("A") + 1
}
