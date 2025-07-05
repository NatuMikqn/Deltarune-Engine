if (!surface_exists(textsrf)){
	draw_set_font(font);
	var _w = string_width(text) * 2,
		_h = string_height(text) * 2;
	textsrf = surface_create(_w, _h);
}

draw_clear_surface(textsrf);