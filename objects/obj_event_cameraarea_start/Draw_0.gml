if (!area_debug) exit;
if (!instance_exists(pair)) exit;

draw_set_colour(c_red);
draw_rectangle(x, y, pair.x, pair.y, true);
draw_set_colour(c_white);