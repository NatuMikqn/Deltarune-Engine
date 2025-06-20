input_step()
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
	var _texd = text_deserialize("<color red>RED<color yellow>YELLOW<>[battle.encountr]twa!");
	new TypeWriterBuilder(20, 20, _texd).set_gui(true).build();
}