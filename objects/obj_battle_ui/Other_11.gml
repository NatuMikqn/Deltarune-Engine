/// @description CharTurn change

if (charturn_prev >= 0 && charturn_prev < array_length(team_get())){
	easing_create(method({id, charturn_prev}, function(_v){
		id.charturn_anim[charturn_prev] = _v;
	}), "battle_ui_charturn_prev_change", false, [new EaseState(4, 1, 10, 0, charturn_anim[charturn_prev], 0, true)])
}

var _charturn = obj_battle.charturn

if (_charturn >= 0 && _charturn < team_get_count()){
	easing_create(method({id : id, ct : _charturn}, function(_v){
		id.charturn_anim[ct] = _v;
	}), "battle_ui_charturn_change", false, [new EaseState(4, 1, 10, 0, charturn_anim[_charturn], 1, true)])
}
if (_charturn >= 1 && _charturn < team_get_count() - 1){
	event_user(2)
}
charturn_prev = _charturn;
//moveline = [];