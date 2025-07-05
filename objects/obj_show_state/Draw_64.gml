surface_set_target(textsrf);

draw_set_font(font);
draw_set_color(c_yellow);
draw_text_transformed(0, 0, text, 2, 2, 0);

surface_reset_target();

surface_set_outline(textsrf, 2, 2);
draw_set_alpha(alpha);

draw_surface(textsrf, 0, 0);

draw_set_alpha(1);