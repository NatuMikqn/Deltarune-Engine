/// @description NewLine

sx = 0
if (tallest_font_height != -1){
	sy += tallest_font_height * yscale
	tallest_font_height = -1
}else{
	draw_set_font(font)
	sy += string_height(" ") * yscale
}