/// @description ShowMove

var _charturn = obj_battle.charturn
easing_create(method({id, show_target, ct : max(1, _charturn)}, function(_v){
	id.show_target = show_target + ((ct - 1) - show_target) * _v;
}), "battle_ui_show_move", false, [new EaseState(4, 1, 30, 0, charturn_anim[_charturn], 1, true)])