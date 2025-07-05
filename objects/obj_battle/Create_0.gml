depth = DEPTH.BATTLE_BG

instance_create_depth(0, 0, DEPTH.UI, obj_battle_ui)
instance_create_depth(320, 180, DEPTH.BOARD, obj_battle_board)
instance_create_depth(320, 200, DEPTH.SOULS, obj_battle_soul_red)

dialogtext = noone;

var _team = team_get(),
	_obj, _pos, _inst


charturn = 0;
select_list = [];
select_step = 0;

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
tension = 0;
tension_history = [];

battle_char_ids = [];
battle_enemy_ids = [];

for (var i=0;i<team_get_count();i++){
	_obj = _team[i].get_obj_battle()
	_pos = _team[i].get_position_encounter()
	_inst = instance_create_depth(_pos.x - camera_get_viewpos_x(), _pos.y - camera_get_viewpos_y(), DEPTH.BT_CHAR-i, _obj)
	_inst.char = i;
	_inst.color = _team[i].get_color()
	array_push(battle_char_ids, _inst);
}
var _enemygroup = get_enemydata().enemygroup;
_pos = new Vector2();
for (var i = 0; i < array_length(_enemygroup); i++) {
	_obj = _enemygroup[i].object;
	_pos.set(_enemygroup[i].x, _enemygroup[i].y)
	_inst = instance_create_depth(_pos.x, _pos.y, _enemygroup[i].depth, _obj)
	array_push(battle_enemy_ids, _inst);
}

dbg_screen_alpha = 0;
dbg_screen_img = 0;