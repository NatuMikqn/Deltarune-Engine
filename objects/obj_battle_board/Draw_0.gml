surface_set_target(obj_battle.srf_battle)
alphafix(true)

//左上 xy+
var _pos = vector2rot(-left * scale, -up * scale, 0, 0, angle)
draw_sprite_ext(spr_pixel, 0, x + _pos.x, y + _pos.y, (left + right) * scale, (up + down) * scale, angle, bg_color, bg_alpha * alpha)
draw_set_ca(l_color, l_alpha * alpha)
draw_board(x, y, left * scale, right * scale, up * scale, down * scale, angle, width * scale)
draw_set_ca()

for(var i=0;i<array_length(afterimage_list);i++){
	afterimage_list[i].draw()
}

alphafix(false)
surface_reset_target()