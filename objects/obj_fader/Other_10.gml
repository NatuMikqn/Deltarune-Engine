///@desc draw

if (alpha > 0) {
	alphafix(true);
	draw_sprite_ext(spr_pixel, 0, 0, 0, 640, 480, 0, c_black, alpha);
	alphafix(false);
}

