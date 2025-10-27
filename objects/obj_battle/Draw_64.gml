surface_set_target(srf_battle);
alphafix(true);
draw_sprite_ext(spr_screen_awase, dbg_screen_img, 0, 0, 0.5, 0.5, 0, c_white, dbg_screen_alpha);
surface_reset_target();

draw_surface(srf_battle, 0, 0);
alphafix(false);


var _names = variable_instance_get_names(id);
var _text = "";
for (var i = 0; i < array_length(_names); i++) {
	_text += $"{_names[i]} : {variable_instance_get(id, _names[i])}\n";
}
draw_set_font(fnt_8bit);
draw_text_outline(40, 20, _text);
