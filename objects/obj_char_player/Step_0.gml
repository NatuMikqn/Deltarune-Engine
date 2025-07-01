//TODO: FIX CHAR MOVE DIRECTION

if (movable){
	
	var _input = {
			l : input_check(INPUT.LEFT),
			r : input_check(INPUT.RIGHT),
			u : input_check(INPUT.UP),
			d : input_check(INPUT.DOWN),
		},
		_spd = {
			l : _input.l * move_speed.left,
			r : _input.r * move_speed.right,
			u : _input.u * move_speed.up,
			d : _input.d * move_speed.down,
		},
		_dash = input_check(INPUT.CANCEL) * (dash_power - 1) + 1;


	var _if_input = (_input.l != _input.r),
		_if_index = !(sprite_index == spr_index.left && sprite_index == spr_index.right)
	if (_if_input && _if_index){
		if (_input.r){
			sprite_index = spr_index.right
			dir = 0
		}else if (_input.l){
			sprite_index = spr_index.left
			dir = 180
		}
	}else{
		_if_input = (_input.u != _input.d)
		_if_index = !(sprite_index == spr_index.up && sprite_index == spr_index.down)
		if (_if_input && _if_index){
			if (_input.d){
				sprite_index = spr_index.down
				dir = 90
			}else if (_input.u){
				sprite_index = spr_index.up
				dir = 270
			}
		}
	}
	_if_input =	(	input_check_pressed(INPUT.LEFT) || 
					input_check_pressed(INPUT.RIGHT) || 
					input_check_pressed(INPUT.UP) || 
					input_check_pressed(INPUT.DOWN)
				)
	if (_if_input && img_reset){
		img = 1
		img_reset = false;
	}
	_if_input = (_input.l != _input.r || _input.u != _input.d)
	if (_if_input){
		img += img_speed / 60 * _dash;
		if (img > image_number){
			img -= image_number
		}
	}else{
		img = 0;
		img_reset = true;
	}

	hsp = (_spd.r - _spd.l) * _dash
	vsp = (_spd.d - _spd.u) * _dash

	event_inherited()
	
	with(obj_char){
		if (encounter_id != -1 && point_in_circle(other.x, other.y, x, y, circle_hitbox)){
			encounter_start(encounter_id, id)
			break;
		}
	}
}else{
	img = 0;
	img_reset = true;
}