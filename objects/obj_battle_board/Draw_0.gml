surface_set_target(battle_get_surface());
alphafix(true);

var _len = array_length(list);
if (scale > 0 && _len){
	var _board_data;
	
	var _name, _a, _b;
	
	for (var i = 0; i < _len; i++) {
		_board_data = list[i];
		
		draw_set_ca(bg_color, bg_alpha);
		draw_background(_board_data)
		
		draw_set_ca(l_color, l_alpha);
		draw_board(_board_data)
	}
	draw_set_ca()
}

for(var i=0;i<array_length(afterimage_list);i++){
	afterimage_list[i].draw()
}

alphafix(false)
surface_reset_target()