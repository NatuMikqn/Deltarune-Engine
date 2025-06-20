/// @description ShowMove

var _charturn = obj_battle.charturn;
if (!array_empty(_charturn)){
	new EasingBuilder(method({ id, show_target, ct : max(1, _charturn)}, function(_v){
				id.show_target = show_target + ((ct - 1) - show_target) * _v;
			}))
			.set_target(true)
			.start(charturn_anim[_charturn])
			.add_step(EASING_TWEEN.QUART, EASING_EASE.OUT, 30, 1)
			.set_tag("battle_ui_show_move")
			.build();
}