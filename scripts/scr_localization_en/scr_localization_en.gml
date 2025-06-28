function localization_en(){
	
	// TODO: Support external JSON
	
	lang_set(LANG.EN);
	
	set_text("l10n.test.0", "<scale 2><speed 3><color red>RED<color yellow>YELLOW<newline><sleep 20>twa![l10n.test.1 123 345]");
	set_text("l10n.test.1", "<color #00ffff>[setting.lang test]<color white>Test       Message!%%j% % %<pause><clear>[l10n.test.2]");
	set_text("l10n.test.2", "<mtt true><speed 18>HELLOW ABCD EFF<color red>FF<pause>[l10n.test.3]");
	set_text("l10n.test.3", "FF GGAK<mtt false><color #007080><speed 3>1234");
	set_text("setting.lang", "English (%)");
	set_text("battle.test.dialog.encounter", "* It is known.");
	
}