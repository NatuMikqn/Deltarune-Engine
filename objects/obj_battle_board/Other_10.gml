///@desc BoardInAnim

easing_create(method(id, function(_v){
	alpha = 0.5 + _v * 0.5;
	scale = _v;
	angle = _v * 180 - 180;
	obj_battle.enemyturn_black = _v * 0.6;
}), "", false, [new EaseState(EASING_TWEEN.LINEAR, EASING_EASE.IN, 30)])

afterimage = true;
delay_create(method(id, function(_v){
	afterimage = false;
}), "", false, 30)