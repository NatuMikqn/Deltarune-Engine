if (!battle_surface || surface_exists(battle_get_surface())){
	if (battle_surface) surface_set_target(battle_get_surface())
	
	//draw_line(x-20,y,x+20,y)
	//draw_line(x,y-20,x,y+20)

	for(var i=0;i<array_length(char_list);i++){
		char_list[i].draw(x, y, xscale, yscale, alpha)
	}

	if (battle_surface) surface_reset_target()
}