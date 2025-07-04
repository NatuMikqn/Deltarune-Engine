for (var i = 0; i < array_length(list); i++) {
	with(list[i]){
		if (!is_gui()) draw();
	}
}