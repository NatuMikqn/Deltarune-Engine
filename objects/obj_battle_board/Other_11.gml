///@desc BoardOutAnim

new EasingBuilder(method(id, function(_v){
			alpha = 1 - _v * 0.5;
			scale = 1 - _v;
			angle = _v * 180;
			obj_battle.enemyturn_black = (1 - _v) * 0.5;
		}))
		.add_step(EASING_TWEEN.LINEAR, EASING_EASE.IN, 30, 1)
		.build();

afterimage = true;
alarm[0] = 30;