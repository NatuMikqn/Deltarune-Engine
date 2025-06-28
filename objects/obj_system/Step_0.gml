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
	var _timer = current_time
	var _texd = text_deserialize("[l10n.test.0]");
	new TypeWriterBuilder(20, 20, _texd).set_gui(true).build();
}
if keyboard_check_pressed(vk_f6){
	show_message(get_text("l10n.test", ["29", 52, "50"]))
}
if keyboard_check_pressed(vk_f7){
	player_damage(88)
}