sprite = spr_font_battlemsg;
spr_h = sprite_get_height(sprite);
type = -1;
text = "";

width = 2.5;
height = 0;
alpha = 1;

color = c_white;

target_surface = -1;
gui = false;

timer = 74;
step = 0;

var _eb = new EasingBuilder(method(id, function (_v) {
	x = xstart - 60 + _v * 60;
}))
_eb.start(0).add_step(3, 1, 1, 24).build();

_eb = new EasingBuilder(method(id, function (_v) {
	y = ystart + _v;
}))
_eb.start(0)
	.set_target(true)
	.add_step(3, 1, -10, 12)
	.add_step(2, 0, 0, 12)
	.set_value(5)
	.add_step(3, 1, -8, 8)
	.add_step(3, 0, 3, 8)
	.set_value(0)
	.build();

_eb = new EasingBuilder(method(id, function (_v) {
	width = 2.5 - _v * 1.5;
	height = _v;
}))
_eb.start(0).add_step(0, 0, 1, 4).build();