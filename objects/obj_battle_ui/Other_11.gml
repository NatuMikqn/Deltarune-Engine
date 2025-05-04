/// @description CharTurn change

if (charturn_prev >= 0 && charturn_prev < array_length(team_get())){
	
	new EasingBuilder(method({id, charturn_prev}, function(_v){
				id.charturn_anim[charturn_prev] = _v;
			}))
			.set_target(true)
			.start(charturn_anim[charturn_prev])
			.add_step(EASING_TWEEN.QUART, EASING_EASE.OUT, 10, 0)
			.set_tag("battle_ui_charturn_prev_change")
			.build();
	
}

var _charturn = obj_battle.charturn

if (_charturn >= 0 && _charturn < team_get_count()){
	
	new EasingBuilder(method({id, _charturn}, function(_v){
				id.charturn_anim[_charturn] = _v;
			}))
			.set_target(true)
			.start(charturn_anim[_charturn])
			.add_step(EASING_TWEEN.QUART, EASING_EASE.OUT, 10, 1)
			.set_tag("battle_ui_charturn_change")
			.build();
	
}
if (_charturn >= 1 && _charturn < team_get_count() - 1){
	event_user(2)
}
charturn_prev = _charturn;
//moveline = [];