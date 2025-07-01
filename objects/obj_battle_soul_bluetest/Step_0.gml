if (movable)
{
	var _spd = spd / (input_check(INPUT.CANCEL) + 1)
	var _pos = new Vector2();
	
	hsp = input_check(INPUT.RIGHT) - input_check(INPUT.LEFT);
	
	if (input_check(INPUT.UP)){
		if (jumpstep == 0){
			vsp = -5.2;
			jumpstep = 1;
		}else if (jumpstep == 1){
			vsp += 0.16;
			if (vsp > -1) jumpstep = 2;
		}
	}else if (jumpstep == 1){
		jumpstep = 2;
		vsp = -1.2;
	}
	if (jumpstep == 2){
		vsp += 0.16;
		
	}
	
	
	x += hsp * _spd;
	y += vsp;
}