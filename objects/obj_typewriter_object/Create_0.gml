
data = {};

///@arg {Bool} is_gui
function draw_heart(_gui)
{
	if (!data.choice) return;
	if (data.is_gui() != _gui) return;
	var _surfacemode = surface_exists(data.get_surface());
	if (_surfacemode) surface_set_target(data.get_surface());
	draw_sprite(spr_battle_soul_red, 0, x - 16, y + 16);
	if (_surfacemode) surface_reset_target();
}