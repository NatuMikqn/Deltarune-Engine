with(obj_battle_team){
	var _val = {
		id,
		x,
		y,
		char
	}
	
	//TODO - ここの処理を作り直す
	new EasingBuilder(method(_val, function(_v){
				id.x = x + (team_get_flag(char, TEAMCHAR_FLAG.BATTLE_X, 0) - x) * _v
				id.y = y + (team_get_flag(char, TEAMCHAR_FLAG.BATTLE_Y, 0) - y) * _v
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