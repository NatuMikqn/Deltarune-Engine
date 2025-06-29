
///@arg {real} value
///@arg {bool} add_history
function battle_tension_add(_add, _history = false){
	if (_add > 0){		//増加時
		with(obj_battle){
			if (_history) battle_tension_add_history(min(100 - tension, _add))
			var _m = min(100, tension + _add)
			easing_destroy("battle_ui_tension_anim")
			
			new EasingBuilder(method(obj_battle_ui, function(_v){
						tension_anim[0] = _v;
						tension_view = _v;
					}))
					.set_target(true)
					.start(tension)
					.add_step(EASING_TWEEN.LINEAR, EASING_EASE.IN, 4, _m)
					.set_tag("battle_ui_tension_anim")
					.build();
			
			new EasingBuilder(method(obj_battle_ui, function(_v){
						tension_anim[2] = _v;
					}))
					.set_target(true)
					.start(tension)
					.add_step(EASING_TWEEN.QUAD, EASING_EASE.OUT, 30, _m)
					.set_tag("battle_ui_tension_anim")
					.build();
			
			tension = _m
			obj_battle_ui.tension_anim[1] = 0;
		}
	}else if (_add < 0){
		battle_tension_sub(-_add)
	}
}

///@arg {real} value
///@arg {bool} add_history
function battle_tension_sub(_sub, _history = true){
	if (_sub > 0){		//減量時
		with(obj_battle){
			if (_history) battle_tension_add_history(min(tension, _sub))
			var _m = max(0, tension - _sub)
			easing_destroy("battle_ui_tension_anim")
			
			new EasingBuilder(method(obj_battle_ui, function(_v){
						tension_anim[2] = _v;
						tension_view = _v;
					}))
					.set_target(true)
					.start(tension)
					.add_step(EASING_TWEEN.LINEAR, EASING_EASE.IN, 4, _m)
					.set_tag("battle_ui_tension_anim")
					.build();
			
			new EasingBuilder(method(obj_battle_ui, function(_v){
						tension_anim[0] = _v;
						tension_anim[1] = _v;
					}))
					.set_target(true)
					.start(tension)
					.add_step(EASING_TWEEN.QUAD, EASING_EASE.OUT, 30, _m)
					.set_tag("battle_ui_tension_anim")
					.build();
			
			tension = _m
		}
	}else if (_sub < 0){
		battle_tension_sub(-_sub)
	}
}

///@arg {real} value
function battle_tension_add_history(_value){
	array_push(obj_battle.tension_history, _value);
}

function battle_tension_prev(){
	battle_tension_sub(array_pop(obj_battle.tension_history), false);
}

function battle_tension_clear_history(){
	obj_battle.tension_history = []
}