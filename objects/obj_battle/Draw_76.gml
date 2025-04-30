if (!surface_exists(srf_battle)) srf_battle = surface_create_auto()

surface_set_target(srf_battle)
alphafix(true)
draw_clear_alpha(c_black, background_alpha)
draw_set_alpha(background_alpha)
var _size = 50
var _x, _y
draw_set_color(#240024)
for(var i=0;i<ceil(640 / _size);i++){
	_x = i * _size + (timer * 0.25 % _size)
	draw_line(_x, 0, _x, 480)
}

for(var i=0;i<ceil(480 / _size) + 1;i++){
	_y = i * _size + (timer * 0.25 % _size)
	draw_line(0, _y, 640, _y)
}
draw_set_color(#420042)
for(var i=0;i<ceil(640 / _size);i++){
	_x = (i + 1) * _size - ((timer * 0.5 + _size * 0.8) % _size)
	draw_line(_x, 0, _x, 480)
}

for(var i=0;i<ceil(480 / _size) + 1;i++){
	_y = (i + 1) * _size - (timer * 0.5 % _size)
	draw_line(0, _y, 640, _y)
}
draw_set_ca()
draw_sprite_ext(spr_pixel, 0, 0, 0, 640, 480, 0, c_black, enemyturn_black)
alphafix(false)
surface_reset_target()