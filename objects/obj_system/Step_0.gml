easing_step()

if keyboard_check_pressed(vk_f1){
	lang_set(lang_get()+1)
	if (lang_get() > 2){
		lang_set(0)
	}
}
if keyboard_check_pressed(vk_f2){
	game_restart()
}
if keyboard_check_pressed(vk_f4){
	window_set_size(1280, 960)
	window_center()
}
if keyboard_check_pressed(vk_f5){
	new TypeWriterBuilder(20, 20, "[l10n.test.0]").set_gui(true).build();
}
if keyboard_check_pressed(vk_f6){
	new TypeWriterBuilder(irandom(320), irandom(460), "[l10n.test.0]").set_gui(true).build();
}
if keyboard_check_pressed(vk_f7){
	player_damage(88)
}