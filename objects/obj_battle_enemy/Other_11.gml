/// @description ActionSelect

switch (battle_get_nowchar()) {
	case "kris":
		battle_act_remove("check")
		battle_act_add("slash", "X-Slash", "hurt", 25)
		break;
	case "susie":
		battle_act_add("s-act", "<teamcolor 1 susie>S-Action", "action", 0)
		battle_remove_act("slash")
		battle_act_add("slash", "Red Buster", "very hurt", char_is_equip("susie", ITEMTYPE.WEAPON, "devil_knife") ? 40 : 50)
		break;
	case "ralsei":
		battle_act_add("s-act", "<teamcolor 1 ralsei>S-Action", "action", 0)
		break;
}