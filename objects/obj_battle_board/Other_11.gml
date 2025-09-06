///@desc BoardOutAnim

new EasingBuilder(0, method(id, function(_v){
			alpha = 1 - _v * 0.5;
			scale = 1 - _v;
			angle = _v * 180;
			obj_battle_background.enemyturn_black = (1 - _v) * 0.5;
		}))
		.add_step(EASING_TWEEN.LINEAR, EASING_EASE.IN, 1, boardanim_speed)
		.set_tag("board_anim")
		.build();

afterimage = true;