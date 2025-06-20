function team_custom(){
	/////////////////////////////////////////////////
	//charcter register
	new CharacterInfoBuilder("kris")
		.set_hp(90)
		.set_color(c_aqua)
		.set_obj_arena(obj_char_player)
		.set_obj_battle(obj_battle_team_kris)
		.set_techable(false)
		.build();
	
	new CharacterInfoBuilder("susie")
		.set_hp(110)
		.set_color(c_fuchsia)
		.set_obj_arena(obj_char_player)
		.set_obj_battle(obj_battle_team_susie)
		.build();
	
	new CharacterInfoBuilder("ralsei")
		.set_hp(70)
		.set_color(c_lime)
		.set_obj_arena(obj_char_player)
		.set_obj_battle(obj_battle_team_ralsei)
		.build();
	
	new CharacterInfoBuilder("noelle")
		.set_hp(90)
		.set_color(c_yellow)
		.set_obj_arena(obj_char_player)
		.set_obj_battle(obj_battle_team_noelle)
		.build();
	
	////////////////////////////////////////////
	//join
	
	team_join("kris")
	team_join("susie")
	team_join("ralsei")
	//team_join("noelle")
}