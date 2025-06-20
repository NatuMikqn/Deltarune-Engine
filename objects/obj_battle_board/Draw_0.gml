surface_set_target(obj_battle.srf_battle)
alphafix(true)

if (scale > 0 && !array_empty(polygons_offset.main)){
	var _polygon, _count = array_length(polygons.main);
	
	draw_set_ca(bg_color, bg_alpha);
	
	draw_primitive_begin(pr_trianglestrip);
	for(var i=0;i<_count + 1;i++){
		_polygon = polygons.main[i % _count].copy();
		
		if (angle % 360 != 0) _polygon.rot(angle).mul(scale);
		
		draw_vertex(x + _polygon.x, y + _polygon.y);
	}
	draw_primitive_end()
	
	draw_set_ca(l_color, l_alpha * alpha);
	draw_board(polygons, polygons_offset, scale, angle)
	draw_set_ca()
}

for(var i=0;i<array_length(afterimage_list);i++){
	afterimage_list[i].draw()
}

alphafix(false)
surface_reset_target()