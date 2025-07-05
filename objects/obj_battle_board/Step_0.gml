if (keyboard_check_pressed(vk_space)){
	
	var _polys = polygons_data[$"main"]
	
	var _nextpolys = [
		new Vector2(irandom_range(-140, 0), irandom_range(-140, 0)),
		new Vector2(irandom_range(-140, 0), irandom_range(0, 140)),
		new Vector2(irandom_range(0, 140), irandom_range(0, 140)),
		new Vector2(irandom_range(0, 140), irandom_range(-140, 0)),
	]
	
	new EasingBuilder(method({id, _polys, _nextpolys}, function(_v){
		var _count = 4;
		var _x, _y, _name;
		for (var i = 0; i < _count; i++) {
			_name = $"x{i}"
			_x = _polys[$_name].pos.x + (_nextpolys[i].x - _polys[$_name].pos.x) * _v
			_y = _polys[$_name].pos.y + (_nextpolys[i].y - _polys[$_name].pos.y) * _v
			board_polygon_set("main", $"x{i}", _x, _y)
		}
		board_update();
	}))
	.add_step(EASING_TWEEN.QUAD, EASING_EASE.OUT, 1, 30)
	.build();
}