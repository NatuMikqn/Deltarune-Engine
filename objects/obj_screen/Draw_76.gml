surface_check("border", display_get_width(), display_get_height());
surface_check("border_mask", display_get_width(), display_get_height());

draw_clear_surface(border);
draw_clear_surface(border_mask);