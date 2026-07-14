easing_step()

// frame skip
if (keyboard_check_pressed(vk_f1) && is_test())
{
	lang_set(lang_get() + 1)
	if (lang_get() >= lang_count()){
		lang_set(0)
	}
}

if (keyboard_check_pressed(vk_f2))
{
	game_restart()
}

if (keyboard_check_pressed(vk_f5) && is_test())
{
	new TypeWriterBuilder(100, 100, "[battle.test.dialog.encounter]").set_gui(true).set_scale(2, 2).build();
}

if (keyboard_check_pressed(vk_f6) && is_test())
{
	new TypeWriterBuilder(irandom(320), irandom(460), "[l10n.test.0]").set_gui(true).set_scale(2, 2).build();
}

if (keyboard_check_pressed(vk_f7) && is_test())
{
	player_damage(0, 88)
}

if (room == rm_init && input_check_pressed(INPUT.CANCEL)) {
	room_goto(rm_logo);
}