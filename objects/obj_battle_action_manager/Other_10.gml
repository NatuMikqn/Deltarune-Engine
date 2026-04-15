/// DefaultAction
// act選択時のデフォルトリスト

battle_act_reset();

switch (battle_get_current_char().get_tag()) {
	case "kris":
		new BattleActBuilder("check")
			.set_infomation("Check", "Useless&analysis")
			.build();
		break;
	
	case "susie":
		new BattleActBuilder("sp_act")
			.set_infomation("<teamcolor susie 1>S-Action", "")
			.set_func_select(function () {
				show_message("select test")
			})
			.build();
		new BattleActBuilder("slash")
			.set_infomation("Rude Buster", "Rude&damage")
			.set_cost(char_is_equip("susie", ITEMTYPE.WEAPON, "devil_knife") ? 40 : 50)
			.set_action(BattleActionSusieBuster)
			.build();
		new BattleActBuilder("heal")
			.set_infomation("BetterHeal", "Heal&ally")
			.set_cost(irandom(99) + 1)
			.build();
		
		break;
	
	case "ralsei":
		new BattleActBuilder("sp_act")
			.set_infomation("<teamcolor ralsei 1>S-Action", "")
			.build();
		new BattleActBuilder("pacify")
			.set_infomation("Pacify", "")
			.set_cost(16)
			.build();
		new BattleActBuilder("heal")
			.set_infomation("Heal Prayer", "")
			.set_cost(16)
			.build();
		break;
}

with (battle_get_targetenemy()) { event_user(1); }