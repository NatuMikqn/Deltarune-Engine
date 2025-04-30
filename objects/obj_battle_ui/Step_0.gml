for(var i=0;i<array_length(moveline);i++){
	moveline[i].step()
	if (moveline[i].alpha < 0){
		array_delete(moveline, i, 1)
		i--
	}
}

if (timer % 30 == 0){
	array_push(moveline, new MoveLine())
}

timer++
