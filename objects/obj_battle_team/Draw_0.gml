surface_set_target(battle_get_surface())

var _sprite = sprite[sprite_anim]

draw_sprite_ext(_sprite, subimg, x, y, 2, 2, 0, c_white, 1)

surface_reset_target()