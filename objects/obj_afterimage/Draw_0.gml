var _surface_enable = (surface != -1 && surface_exists(surface));
if (_surface_enable) surface_set_target(surface);
alphafix(true);
draw_sprite_ext(sprite, img, x, y, scale.x, scale.y, 0, c_white, alpha);
alphafix(false);
if (_surface_enable) surface_reset_target();