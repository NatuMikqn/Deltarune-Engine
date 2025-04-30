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
	
	var _e = new EasingCreate(method(id, function(_v){
			aaa = _v;
		}))
		.start(2)
		.sleep(20)
		.add(5, 0, 40, 1)
		.sleep(60)
		.set(0.1)
		.target(true);
	
	easing_run(_e);
	
}