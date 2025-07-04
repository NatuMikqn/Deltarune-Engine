fps_list[fps_list_pos] = fps_real
fps_list_pos++
if fps_list_pos > fps_list_max{
	fps_list_pos = 0
}

var _total = 0
for(var i=0;i<array_length(fps_list);i++){
	_total+=fps_list[i]
}
fps_frame = round(_total / array_length(fps_list))
if (timer % 60 == 0) fps_sec = round(_total / array_length(fps_list))


if (keyboard_check(vk_control) && keyboard_check_pressed(ord("F"))){
	visible = !visible;
}