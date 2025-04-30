///@desc BoardOutAnim

easing_create(method(id, function(_v){
	alpha = 1 - _v * 0.5;
	scale = 1 - _v;
	angle = _v * 180;
	obj_battle.enemyturn_black = (1 - _v) * 0.5;
}), "", false, [new EaseState(EASING_TWEEN.LINEAR, EASING_EASE.IN, 30)])

afterimage = true;
delay_create(method(id, function(_v){
	afterimage = false;
}), "", false, 30)