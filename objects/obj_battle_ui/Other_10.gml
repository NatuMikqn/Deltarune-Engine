/// @description InAnim

new EasingBuilder(method(id, function(_v){
			in_anim = _v;
		}))
		.add_step(EASING_TWEEN.QUART, EASING_EASE.OUT, 30, 1)
		.build();