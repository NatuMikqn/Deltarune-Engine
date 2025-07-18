screen_size = new Vector2(640, 480);

//-1 : fullscreen
//-2 : dotbydot
//-3 : fullscreen - borderless
//-4 : dotbydot - borderless
fullscreen = [
	new Vector2(screen_size.x, screen_size.y),
	new Vector2(screen_size.x * 2, screen_size.y * 2),
	new Vector2(-4),
	new Vector2(-3),
]
fullscreen_select = 0;
dotbydot = false;
frameskip = 0;

application_surface_draw_enable(false);