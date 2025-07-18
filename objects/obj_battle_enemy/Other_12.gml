/// @description ActionRun

var _char = battle_get_nowchar();
switch (battle_get_current_act()) {
	case "check":
		battle_set_dialog("ACT-san");
		battle_act_set_autonext(BATTLE_AUTONEXT.DIALOG_END);
		break;
	case "slash":
		var _dialog = "";
		if (_char == "kris") _dialog = "Kris Slash";
		if (_char == "susie") _dialog = "Susie Slash";
		battle_set_dialog(_dialog);
		battle_char_playaction("slash");
		battle_act_set_autonext(BATTLE_AUTONEXT.USER);
}