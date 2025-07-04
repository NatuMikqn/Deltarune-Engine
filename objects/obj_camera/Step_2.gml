var _shake = new Vector2()
if (shake.pos.x > 0){
	shake.pos.x = max(0, shake.pos.x - shake.spd.x);
	_shake.x = shake.pos.x * (1 - irandom(1) * 2);
}
if (shake.pos.y > 0){
	shake.pos.y = max(0, shake.pos.y - shake.spd.y);
	_shake.y = shake.pos.y * (1 - irandom(1) * 2);
}

var _size = new Vector2(global.screen_size.x, global.screen_size.y);

if (target != noone){
	x = target.x - _size.x/2
	y = target.y - _size.y/2
}

var _pos = new Vector2(x + _shake.x, y + _shake.y);
if (limit){
	_pos.x = clamp(_pos.x, 0, room_width-_size.x)
	_pos.y = clamp(_pos.y, 0, room_height-_size.y)
}
camera_set_view_pos(camera, _pos.x, _pos.y);
viewpos.set(_pos);
camera_set_view_size(camera, _size.x * scale.x, _size.y * scale.y);
camera_set_view_angle(camera, angle);