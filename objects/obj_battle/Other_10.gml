///@desc SelectReset

var _slm = function(){
	return [0];
}
charturn = 0;
select_list = array_create_ext(team_get_count(), _slm);
select_step = 0;
obj_battle_ui.charturn_icon_img = array_create(team_get_count(), 0);
with(obj_battle_team) battle_team_set_anim(id, BATTLE_TEAM_ANIM.IDLE, BATTLE_ANIM_LOOP.LOOP, 10)