
if (movable){
	var _spd = {
			l : irandom(1) * move_speed.left,
			r : irandom(1) * move_speed.right,
			u : irandom(1) * move_speed.up,
			d : irandom(1) * move_speed.down,
		}

	hsp = _spd.r - _spd.l
	vsp = _spd.d - _spd.u

	event_inherited()
}else{
	
}