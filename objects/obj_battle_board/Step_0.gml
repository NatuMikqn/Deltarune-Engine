for(var i=0;i<array_length(afterimage_list);i++){
	afterimage_list[i].step()
	if (afterimage_list[i].ai_alpha < 0){
		array_delete(afterimage_list, i, 1)
		i--
	}
}

if (afterimage){
	
	if (timer % 2 == 0){
		array_push(afterimage_list, new CreateAfterimage(1 - alpha + 0.1))
	}
}

timer++