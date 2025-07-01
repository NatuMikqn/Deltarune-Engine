if (start){
	timer ++
	if (timer == 1){
		obj_battle_soul.show = true;
		obj_battle_soul.hitbox = true;
		obj_battle_soul.movable = true;
	}
	if (timer > 10){
		var _data = board_get_data("main")
		_data.clear()
		var _poly = 18;
		for (var i = 0; i < _poly; i++) {
			var _len = 80 + i % 2 * 40;
			var _dir = i * 360 / _poly;
			_data.add($"{i}", lengthdir_x(_len, _dir), lengthdir_y(_len, _dir))
		} 
		_data.set_angle(timer)
		board_update()
		//battle_turn_end()
	}
}
