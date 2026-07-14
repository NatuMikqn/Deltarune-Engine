
/// ダークナー世界でのダイアログボックス描画
/// @arg {Real} Left
/// @arg {Real} Top
/// @arg {Real} Right
/// @arg {Real} Bottom
function draw_dialogbox(x1, y1, x2, y2) {
	static jewel = 0;
	static jewel_list = [
		#ffffff, #aaffe6, #8cceff, #7191ff,
		#513eff, #7191ff, #8cceff, #aaffe6];
	jewel += 0.05;
	
	var _tl_size = new Vector2(
		sprite_get_width(spr_dialogbox_topleft) * 2,
		sprite_get_height(spr_dialogbox_topleft) * 2
	)
	
	var _width = x2 - x1 - _tl_size.x * 2;
	if (_width < 0) _width = 0;
	
	var _height = y2 - y1 - _tl_size.y * 2;
	if (_height < 0) _height = 0;
	
	if (_width > 0 && _height > 0) {
	}
	
	
	if (_width > 0) {
		draw_sprite_ext(spr_dialogbox_top, 0, x1 + _tl_size.x, y1, _width, 2, 0, c_white, 1);
		draw_sprite_ext(spr_dialogbox_top, 0, x1 + _tl_size.x, y2, _width, -2, 0, c_white, 1);
	}
	
	if (_height > 0) {
		draw_sprite_ext(spr_dialogbox_left, 0, x1, y1 + _tl_size.y, 2, _height, 0, c_white, 1);
		draw_sprite_ext(spr_dialogbox_left, 0, x2, y1 + _tl_size.y, -2, _height, 0, c_white, 1);
	}
	
	var jewel_color = jewel_list[jewel % 8];
	draw_sprite_ext(spr_dialogbox_topleft, 0, x1, y1, 2, 2, 0, c_white, 1);
	draw_sprite_ext(spr_pixel, 0, x1 + 12, y1 + 12, 2, 2, 0, jewel_color, 1);
	draw_sprite_ext(spr_dialogbox_topleft, 0, x2, y1, -2, 2, 0, c_white, 1);
	draw_sprite_ext(spr_pixel, 0, x2 - 14, y1 + 12, 2, 2, 0, jewel_color, 1);
	draw_sprite_ext(spr_dialogbox_topleft, 0, x1, y2, 2, -2, 0, c_white, 1);
	draw_sprite_ext(spr_pixel, 0, x1 + 12, y2 - 14, 2, 2, 0, jewel_color, 1);
	draw_sprite_ext(spr_dialogbox_topleft, 0, x2, y2, -2, -2, 0, c_white, 1);
	draw_sprite_ext(spr_pixel, 0, x2 - 14, y2 - 14, 2, 2, 0, jewel_color, 1);
	draw_sprite_ext(spr_pixel, 0, x1 + _tl_size.x, y1 + _tl_size.y, _width, _height, 0, c_black, 1)
}