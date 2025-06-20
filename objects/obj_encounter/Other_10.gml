with(obj_battle_team){
	var _val = {
		id,
		x,
		y,
		char
	}
	
	//TODO - ここの処理を作り直す
	new EasingBuilder(method(_val, function(_v){
				var _pos = team_get()[char].get_position_battle()
				id.x = x + (_pos.x - x) * _v
				id.y = y + (_pos.y - y) * _v
			}))
			.add_step(EASING_TWEEN.LINEAR, EASING_EASE.IN, 20, 1)
			.build();
	
	new EasingBuilder(method(_val, function(_v){
				if ((_v * 20) % 4 == 0){
					afterimage_create(id.x, id.y, id.depth + 1, id.sprite[id.sprite_anim], id.subimg, 2, 2).surface = battle_get_surface();
				}
			}))
			.add_step(EASING_TWEEN.LINEAR, EASING_EASE.IN, 20, 1)
			.build();
}