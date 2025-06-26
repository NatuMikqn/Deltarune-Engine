if (timer > 0){
	timer --
	if (timer == 0){
		switch (step) {
			case 0:
				
				timer = 24;
				
				break;
			case 1:
				instance_destroy();
				break;
		}
		step++;
	}
}
if (step == 1){
	y -= 2.5;
	height += 1 / spr_h * 1.25;
	alpha -= 1 / 24
}