//TODO: FIX CHAR MOVE DIRECTION
//TODO: 他キャラも操作できるように、オブジェクトを分岐させる

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
	
	//向いている向きとそれに対応するキーが離された 又は 対のキーが押されたら方向固定を解除する
	if (facinglock){
		img += img_speed / 60;
		var _if = (((facingdir == AREA_FACINGDIR.LEFT && !_input.l) || (facingdir == AREA_FACINGDIR.RIGHT && !_input.r)) ||
				((facingdir == AREA_FACINGDIR.LEFT || facingdir == AREA_FACINGDIR.RIGHT) && (_input.l && _input.r))) ||
				(((facingdir == AREA_FACINGDIR.DOWN && !_input.d) || (facingdir == AREA_FACINGDIR.UP && !_input.u)) ||
				((facingdir == AREA_FACINGDIR.DOWN || facingdir == AREA_FACINGDIR.UP) && (_input.d && _input.u)))
		if (_if){
			facinglock = false;
			imgplay = false;
		}
	}
	
	if (!facinglock){
		if (_input.l != _input.r){
			if (_input.l){
				sprite_index = spr_index.left;
				facingdir = AREA_FACINGDIR.LEFT;
				facinglock = true;
			}else if (_input.r){
				sprite_index = spr_index.right;
				facingdir = AREA_FACINGDIR.RIGHT;
				facinglock = true;
			}
		}else if (_input.d != _input.u){
			if (_input.d){
				sprite_index = spr_index.down;
				facingdir = AREA_FACINGDIR.DOWN;
				facinglock = true;
			}else if (_input.u){
				sprite_index = spr_index.up;
				facingdir = AREA_FACINGDIR.UP;
				facinglock = true;
			}
		}
		if (facinglock){
			imgplay = true;
		}
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
}