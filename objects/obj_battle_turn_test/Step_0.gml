if (start){
	timer ++
	if (timer == 10){
		instance_create_depth(320, 200, DEPTH.SOULS, obj_battle_soul_red);
		boo = new BoardCircle(420, 200, 1, 125)
		
		board_data_register(boo, "circle")
	}
	if (timer > 10){
		//boo.set_angle(timer)
		
		board_update()
	}
}
