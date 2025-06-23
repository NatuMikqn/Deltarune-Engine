if (start){
	timer ++
	if (timer == 10){
		obj_battle_soul.show = true;
		obj_battle_soul.hitbox = true;
		obj_battle_soul.movable = true;
		//boo = new BoardCircle(420, 200, 1, 125)
		
		//board_data_register(boo, "circle")
	}
	if (timer > 10){
		//boo.set_angle(timer)
		
		board_update()
	}
}
