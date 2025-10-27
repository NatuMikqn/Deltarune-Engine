/// @description ActionSelect

switch (battle_get_current_char().get_tag()) {
	case "kris":
		battle_act_remove("check");
		new BattleActBuilder("check")
			.set_infomation("Checker", "A")
			.build();
		break;
}
