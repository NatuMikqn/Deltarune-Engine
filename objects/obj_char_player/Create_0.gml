event_inherited()

overworld_set_state(OW_STATE.FIELD)

move_speed = {
	left	:	3,
	right	:	3,
	up		:	3,
	down	:	3
}
spr_index = {
	left	:	spr_char_dwkris_walk_left,
	right	:	spr_char_dwkris_walk_right,
	up		:	spr_char_dwkris_walk_up,
	down	:	spr_char_dwkris_walk_down
}
dash_power = 1.5;
img_speed = 6;

dir = 90;

move_dir = 0; //0: none - 1: lr - 2: ud

obj_camera.target = id
