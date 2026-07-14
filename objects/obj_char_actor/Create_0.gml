event_inherited();

is_controllable = false;
movable = true;
is_moved = false;

spr_index = {
	left	:	undefined,
	right	:	undefined,
	up		:	undefined,
	down	:	undefined
}
move_speed = 3;

dash_power = 1.5;
facing_dir = AREA_FACINGDIR.DOWN;
apply_sprite(facing_dir);

encounter_id = -1;
encounter_circle_hitbox = 16;

hitbox_size = new Vector2(bbox_right - bbox_left, bbox_bottom - bbox_top);

interaction_offset = new Vector2();
interaction_size = new Vector2();
interaction_distance = 20;
interaction_area_update();

function controlling_process() {
	var _input = {
		l : input_check(INPUT.LEFT),
		r : input_check(INPUT.RIGHT),
		u : input_check(INPUT.UP), 
		d : input_check(INPUT.DOWN),
	};
	
	var _dash = input_check(INPUT.CANCEL) * (dash_power - 1) + 1;
	
	// InputAxis
	var _velocity = new Vector2(
		_input.r - _input.l,
		_input.d - _input.u
	)
	
	if (is_moved) is_moved = false;
	
	if (_velocity.distance() < 0.1) {
		anim_reset();
		return;
	}
	
	var _direction = get_new_direction(_velocity.x, _velocity.y);
	
	_velocity.mul(move_speed * _dash);
	collision_check(_velocity);
	if (_velocity.distance() < 0.1) {
		anim_reset();
	} else {
		is_moved = true;
	}
	
	if (_direction == AREA_FACINGDIR.NONE || _direction == facing_dir) return;
	
	facing_dir = _direction;
	apply_sprite(_direction);
	interaction_area_update();
}

/// @arg {Real} hsp
/// @arg {Real} vsp
function get_new_direction(_hsp, _vsp) {
	// 移動してなければ何もしない
	if (_hsp == 0 && _vsp == 0) return AREA_FACINGDIR.NONE;
	
	// 各方向への単一入力がされているかどうかで向きを返す
	if (_vsp < 0 && _hsp == 0) return AREA_FACINGDIR.UP;
	if (_vsp > 0 && _hsp == 0) return AREA_FACINGDIR.DOWN;
	if (_hsp < 0 && _vsp == 0) return AREA_FACINGDIR.LEFT;
	if (_hsp > 0 && _vsp == 0) return AREA_FACINGDIR.RIGHT;
	
	// 斜め移動処理
	// 現在向いている向きの入力が押されているままであるかどうか
	var _keeps_current_dir;
	switch (facing_dir) {
		case AREA_FACINGDIR.UP: _keeps_current_dir = (_vsp < 0); break;
		case AREA_FACINGDIR.DOWN: _keeps_current_dir = (_vsp > 0); break;
		case AREA_FACINGDIR.LEFT: _keeps_current_dir = (_hsp < 0); break;
		case AREA_FACINGDIR.RIGHT: _keeps_current_dir = (_hsp > 0); break;
		default: _keeps_current_dir = false;
	}
	
	if (_keeps_current_dir) return AREA_FACINGDIR.NONE;
	
	return (_hsp < 0 ? AREA_FACINGDIR.LEFT : AREA_FACINGDIR.RIGHT);
}

/// @arg {Struct.Vector2} velocity 速度
function collision_check(_velocity) {
	// TODO: 実装
	x += _velocity.x;
	y += _velocity.y;
}

function apply_sprite(_dir) {
	var _target_sprite = undefined;
	switch (_dir) {
		case AREA_FACINGDIR.UP: _target_sprite = spr_index.up; break;
		case AREA_FACINGDIR.DOWN: _target_sprite = spr_index.down; break;
		case AREA_FACINGDIR.LEFT: _target_sprite = spr_index.left; break;
		case AREA_FACINGDIR.RIGHT: _target_sprite = spr_index.right; break;
	}
	
	if (!is_undefined(_target_sprite)) {
		sprite_index = _target_sprite;
	}
}

function interaction_area_update() {
	// 移動方向を1の長さのvectorで取得
	var _dir_vec;
	switch (facing_dir) {
		case AREA_FACINGDIR.UP: _dir_vec = new Vector2().up(); break;
		case AREA_FACINGDIR.DOWN: _dir_vec = new Vector2().down(); break;
		case AREA_FACINGDIR.LEFT: _dir_vec = new Vector2().left(); break;
		case AREA_FACINGDIR.RIGHT: _dir_vec = new Vector2().right(); break;
	}
	var _abs_dir = _dir_vec.copy().apply_abs();
	var _prep_vec = new Vector2(_abs_dir.y, _abs_dir.x);
	
	// 判定エリアの位置をずらしてから
	// 自身の判定エリアの半分ずらす
	var rotated_hitbox_len = hitbox_size.copy().mul(_abs_dir).distance();
	var total_half_length = (rotated_hitbox_len + interaction_distance) / 2.0;
	interaction_offset = _dir_vec.copy().mul(total_half_length);
	interaction_offset.y -= hitbox_size.y / 2;
	
	var base_size = _dir_vec.mul(interaction_distance).apply_abs();
	var margin_size = _prep_vec.mul(hitbox_size.copy().mul(0.9));
	
	interaction_size = base_size.add(margin_size);
}

function motion_process() {}