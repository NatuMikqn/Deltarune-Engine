///@arg {real} x
///@arg {real} y
///@arg {real} left
///@arg {real} right
///@arg {real} up
///@arg {real} down
///@arg {real} angle
///@arg {real} width
function draw_board(_x, _y, _left, _right, _up, _down, _angle, _width = 5){
	
	var _pos
	//左上
	_pos = vector2rot(-_left - _width, -_up - _width, 0, 0, _angle)
	draw_sprite_ext(spr_pixel, 0, _x + _pos.x, _y + _pos.y, _left + _right + _width, _width, _angle, draw_get_color(), draw_get_alpha())
	//左上 y+
	_pos = vector2rot(-_left - _width, -_up, 0, 0, _angle)
	draw_sprite_ext(spr_pixel, 0, _x + _pos.x, _y + _pos.y, _width, _up + _down + _width, _angle, draw_get_color(), draw_get_alpha())
	//右上
	_pos = vector2rot(_right, -_up - _width, 0, 0, _angle)
	draw_sprite_ext(spr_pixel, 0, _x + _pos.x, _y + _pos.y, _width, _up + _down + _width, _angle, draw_get_color(), draw_get_alpha())
	//左下 x+
	_pos = vector2rot(-_left, _down, 0, 0, _angle)
	draw_sprite_ext(spr_pixel, 0, _x + _pos.x, _y + _pos.y, _left + _right + _width, _width, _angle, draw_get_color(), draw_get_alpha())
	
}