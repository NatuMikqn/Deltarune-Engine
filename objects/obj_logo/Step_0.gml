time ++;

if (time == 161) {
	step = 1;
}

if (time == 281) {
	step = 2;
	factor_effect = 0;
	easing_run(id, "factor_alpha", 0, 0, 1, -1, 300, 40);
	easing_run(id, "factor_logoalpha", 0, 0, 1, -1, 220, 120);
}

if (time == 580) {
	can_skip = false;
}

if (time == 700) {
	room_goto(rm_menu);
}

if (step == 2) {
	factor_effect += 0.025;
}

if (input_check_pressed(INPUT.CONFIRM) && can_skip) {
	can_skip = false;
	fader_run(0, 1, 100);
	audio_sound_gain(sound_intro, 0, 1500);
	new EasingBuilder(0, function () { room_goto(rm_menu); }).add_sleep(100).set_value(0).build();
}

