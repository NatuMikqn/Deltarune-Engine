
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
next_state = -1;
next_state_timer = -1;
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

dbg_screen_alpha = 0;
dbg_screen_img = 0;