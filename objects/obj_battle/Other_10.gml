///@desc SelectReset
//キャラクターのボタン選択をリセットします

charturn = 0;
select_list = array_create_ext(team_get_count(), function(){return [0]});
select_step = 0;

//キャラクターのアイコンを通常に戻す
obj_battle_ui.charturn_icon_img = array_create(team_get_count(), 0);

//キャラクターのアニメーションを通常に戻す
with(obj_battle_team) battle_team_set_anim(id, BATTLE_TEAM_ANIM.IDLE, BATTLE_ANIM_LOOP.LOOP, 10)