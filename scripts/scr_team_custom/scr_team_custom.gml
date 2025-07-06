function team_custom()
{
	team_custom_button()
	
	/////////////////////////////////////////////////
	//charcter register
	
	new CharacterInfoBuilder("kris")
		.set_hp(90)
		.set_color(c_aqua)
		.set_obj_arena(obj_char_player)
		.set_obj_battle(obj_battle_team_kris)
		.apply_button(team_get_button("defaultKris"))
		.set_charbox_info(spr_charbox_icon_kris, "charbox.name.kris")
		.build();
	
	new CharacterInfoBuilder("susie")
		.set_hp(110)
		.set_color(c_fuchsia)
		.set_obj_arena(obj_char_player)
		.set_obj_battle(obj_battle_team_susie)
		.apply_button(team_get_button("defaultMons"))
		.set_charbox_info(spr_charbox_icon_susie, "charbox.name.susie")
		.build();
	
	new CharacterInfoBuilder("ralsei")
		.set_hp(70)
		.set_color(c_lime)
		.set_obj_arena(obj_char_player)
		.set_obj_battle(obj_battle_team_ralsei)
		.apply_button(team_get_button("defaultMons"))
		.set_charbox_info(spr_charbox_icon_ralsei, "charbox.name.ralsei")
		.build();
	
	new CharacterInfoBuilder("noelle")
		.set_hp(90)
		.set_color(c_yellow)
		.set_obj_arena(obj_char_player)
		.set_obj_battle(obj_battle_team_noelle)
		.apply_button(team_get_button("defaultMons"))
		.set_charbox_info(spr_charbox_icon_noelle, "charbox.name.noelle")
		.build();
	
	////////////////////////////////////////////
	//join
	
	team_join("kris")
	team_join("kris")
	team_join("kris")
	//team_join("noelle")
}