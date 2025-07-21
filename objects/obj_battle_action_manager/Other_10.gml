///@desc DefaultAction

battle_act_reset();

switch (battle_get_current_char().get_tag()) {
	case "kris":
		battle_act_add("chech", "Check", "Useless&analysis", 0);
		break;
	case "susie":
		battle_act_add("sp_act", "<teamcolor 1 susie>S-Action", "", 0);
		battle_act_add("slash", "Rude Buster", "Rude&damage", char_is_equip("susie", ITEMTYPE.WEAPON, "devil_knife") ? 40 : 50);
		battle_act_add("heal", "BetterHeal", "Heal&ally", irandom(99) + 1);
		break;
	case "ralsei":
		battle_act_add("sp_act", "<teamcolor 1 ralsei>R-Action", "", 0);
		battle_act_add("pacify", "Pacify", "", 16);
		battle_act_add("heal", "Heal Prayer", "", 16);
		break;
}

with (battle_get_targetenemy()) { event_user(1); }