instance_create_depth(0, 0, DEPTH.UI, obj_battle_ui)
instance_create_depth(0, 0, DEPTH.BATTLE_BG, obj_battle_background)
instance_create_depth(0, 0, 0, obj_battle_action_manager)
instance_create_depth(320, 180, DEPTH.BOARD, obj_battle_board)
instance_create_depth(320, 200, DEPTH.SOULS, obj_battle_soul_red)

var _team = team_get(),
	_obj, _pos, _inst

//Battle_Infomation-----------------------------------

#region temp

charturn = 0;
selectmode = DIALOG_UI.BUTTON;

#endregion

#region temp

select_button = [];
buttonlist = [];
nextfunc = -1;
actionlist = [];
enemy_target = noone;
select_tech = -1;

#endregion

char_action = [];
dialog_list = -1;

event_user(0)

timer = 0;
enemy_list = [];
music = -1;

srf_battle = -1;

state = BATTLE_STATE.START_ANIM;
next_state = -1;
next_state_timer = -1;
dialog = "* It is known.";
tension = 0;
tension_history = [];

battle_char_ids = [];
battle_enemy_ids = [];

//チーム配置
for (var i=0;i<team_get_count();i++){
	_obj = _team[i].get_obj_battle()
	_pos = _team[i].get_position_encounter()
	_inst = instance_create_depth(_pos.x - camera_get_viewpos_x(), _pos.y - camera_get_viewpos_y(), DEPTH.BT_CHAR-i, _obj)
	_inst.char = i;
	_inst.color = _team[i].get_color_first()
	battle_team_set_anim(_inst, BATTLE_TEAM_ANIM.ENCOUNTER, true)
	array_push(battle_char_ids, _inst);
}

//敵配置
var _enemygroup = get_enemydata().enemygroup,
	_data;
_pos = new Vector2();
for (var i = 0; i < array_length(_enemygroup); i++) {
	
	_obj = _enemygroup[i].data.object;
	_pos.set(_enemygroup[i].pos.x, _enemygroup[i].pos.y);
	
	_inst = instance_create_depth(_pos.x, _pos.y, -200, _obj);
	_inst.data = _enemygroup[i].data;
	
	array_push(battle_enemy_ids, _inst);
}

dbg_screen_alpha = 0;
dbg_screen_img = 0;