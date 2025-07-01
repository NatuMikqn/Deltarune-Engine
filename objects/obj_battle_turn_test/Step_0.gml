if (start){
	timer ++
	if (timer == 1){
		obj_battle_soul.show = true;
		obj_battle_soul.hitbox = true;
		obj_battle_soul.movable = true;
		var _data = board_get_data("main")
		_data.clear()
		_data.add("1", -60, -40)
		_data.add("2", -60, 80)
		_data.add("3", 80, 80)
		_data.add("4", 80, -100)
		_data.add("5", -100, -100)
		_data.add("6", -100, -60)
		_data.add("7", 20, -60)
		_data.add("8", 20, 40)
		_data.add("9", -20, 40)
		_data.add("a", -20, -40)
		board_update()
	}
	if (timer > 10){
		
		
		//battle_turn_end()
	}
}
