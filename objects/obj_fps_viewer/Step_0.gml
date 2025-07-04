fps_sec_list[fps_sec_list_pos] = fps_real
fps_sec_list_pos++
if fps_sec_list_pos > fps_sec_list_max{
	fps_sec_list_pos = 0
}
if (timer % 60 == 0){
	var _total = 0
	for(var i=0;i<array_length(fps_sec_list);i++){
		_total+=fps_sec_list[i]
	}
	fps_sec = round(_total / array_length(fps_sec_list))
}