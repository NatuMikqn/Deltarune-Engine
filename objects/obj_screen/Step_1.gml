if (keyboard_check_pressed(vk_f4))
{
	fullscreen_select++
	if (fullscreen_select >= array_length(fullscreen)) fullscreen_select = 0;
	event_user(0);
}