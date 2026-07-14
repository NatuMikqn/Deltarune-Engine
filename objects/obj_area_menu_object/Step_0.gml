if (input_check_pressed(INPUT.CANCEL)) {
	audio_play_sound(snd_cancel, 0, 0);
	instance_destroy();
}