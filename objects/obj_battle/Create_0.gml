
depth = DEPTH.BATTLE_BG
instance_create_depth(0, 0, 0, obj_battle_ui)
instance_create_depth(320, 180, 0, obj_battle_board)

var _team = team_get(),
	_obj, _x, _y, _inst

event_user(0)

timer = 0;
enemy_list = [];
music = -1;

srf_battle = -1;
background_alpha = 0;
enemyturn_black = 0;

state = BATTLE_STATE.START_ANIM;
dialog = "* It is known.";
dialog_typer = noone;
tension = 0;
tension_history = [];

for (var i=0;i<team_get_count();i++){
	_obj = team_get_flag(_team[i], TEAMCHAR_FLAG.BATTLE_OBJ)
	_x = team_get_flag(_team[i], TEAMCHAR_FLAG.ENCOUNTER_X) - obj_camera.x
	_y = team_get_flag(_team[i], TEAMCHAR_FLAG.ENCOUNTER_Y) - obj_camera.y
	_inst = instance_create_depth(_x, _y, DEPTH.BT_CHAR-i, _obj)
}

//in battle
easing_create(method(id, function(_v){
	background_alpha = _v;
}), "", false, [new EaseState(0, 0, 20)])

//weapon
delay_create(method(id, function(){
	
	audio_play_sound(snd_impact, 0, 0, 0.7)
	audio_play_sound(snd_weaponpull_fast, 0, 0, 0.8)
	
	with(obj_battle_team) battle_team_set_anim(id, BATTLE_TEAM_ANIM.SETUP, BATTLE_ANIM_LOOP.ONLY)
	
}), "", false, 20)

//start battle!
delay_create(method(id, function(){
	
	with(obj_battle_ui) event_user(0)
	with(obj_battle_team) battle_team_set_anim(id, BATTLE_TEAM_ANIM.IDLE, BATTLE_ANIM_LOOP.LOOP, 10)
	
	battle_set_state(BATTLE_STATE.MYTURN)
	bgm_play(1, music)
	
}), "", false, 48)

dbg_screen_alpha = 0;
dbg_screen_img = 0;