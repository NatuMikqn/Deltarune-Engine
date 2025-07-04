
var _sum = 0;
draw_set_font(l10n_get_font("default", 0))
var _fps, _warn, _low, _height = 100
var _y = 480-3

//background
draw_set_color(c_black)
draw_set_alpha(0.75)
draw_rectangle(0, _y - _height + 1, fps_list_max, _y, false)
draw_set_alpha(1)

//line fps
for(var i=0;i<array_length(fps_list);i++){
	_fps = 30 * _height / fps_list[i]
	_warn = fps_list[i] < 60
	_low = fps_list[i] < 30
	draw_set_color(make_color_hsv(_low ? 0 : (_warn ? 40 : 85),255,255 - ((fps_list_max + (fps_list_pos - 1) - i) % fps_list_max) / 1.5))
	draw_line(i, _y, i, _y-_fps);
}
//目安
draw_set_color(c_ltgray)
draw_line(0, _y - _height/2, fps_list_max, _y - _height/2)
draw_text(2, _y - _height/2 + 2, "60")
draw_line(0, _y - _height, fps_list_max, _y - _height)
draw_text(2, _y - _height + 2, "30")
//平均線
draw_set_color(c_blue)
draw_line(0, _y - 30 * _height / fps_sec, fps_list_max, _y - 30 * _height / fps_sec)
draw_set_color(c_aqua)
draw_line(0, _y - 30 * _height / fps_frame, fps_list_max, _y - 30 * _height / fps_frame)

//top line
draw_set_color(c_white)
draw_set_align(6)
draw_text(2, _y - _height, $"{fps_sec}({fps_frame})")
draw_set_color(c_yellow)
draw_text(76, _y - _height, "Invisible [Ctrl] + [F]")
draw_set_color(c_white)
draw_set_align(0)