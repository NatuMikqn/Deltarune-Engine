
for(var i=0;i<array_length(afterimage_list);i++){
	afterimage_list[i].step()
	if (afterimage_list[i].fadeout < 0){
		array_delete(afterimage_list, i, 1)
		i--
	}
}

if (afterimage){
	
	if (easing_exists("board_anim")){
		if (timer % 2 == 0){
			array_push(afterimage_list, new CreateAfterimage(1 - alpha + 0.1))
		}
	}else{
		afterimage = false;
	}
}


timer++


if (keyboard_check_pressed(vk_space)){
	
	var _polys = polygons.main
	
	var _nextpolys = [
		new Vector2(irandom_range(-140, 0), irandom_range(-140, 0)),
		new Vector2(irandom_range(-140, 0), irandom_range(0, 140)),
		new Vector2(irandom_range(0, 140), irandom_range(0, 140)),
		new Vector2(irandom_range(0, 140), irandom_range(-140, 0)),
	]
	
	new EasingBuilder(method({id, _polys, _nextpolys}, function(_v){
		var _count = array_length(id.polygons.main);
		for (var i = 0; i < _count; i++) {
			id.polygons.main[i].x = _polys[i].x + (_nextpolys[i].x - _polys[i].x) * _v;
			id.polygons.main[i].y = _polys[i].y + (_nextpolys[i].y - _polys[i].y) * _v;
		}
		board_update();
	}))
	.add_step(EASING_TWEEN.QUAD, EASING_EASE.OUT, 30, 1)
	.build();
}