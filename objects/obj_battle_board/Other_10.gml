///@desc BoardInAnim

new EasingBuilder(method(id, function(_v){
			alpha = 0.5 + _v * 0.5;
			scale = _v;
			angle = _v * 180 - 180;
			obj_battle.enemyturn_black = _v * 0.6;
		}))
		.add_step(EASING_TWEEN.LINEAR, EASING_EASE.IN, 1, boardanim_speed)
		.set_tag("board_anim")
		.build();

afterimage = true;