var _spd = spd - (input_check(INPUT.CANCEL) * 0.5)
var _pos = new Vector2();

hsp = input_check(INPUT.RIGHT) - input_check(INPUT.LEFT);
vsp = input_check(INPUT.DOWN) - input_check(INPUT.UP);
_pos = new Vector2(x + hsp * _spd, y + vsp * _spd);

var _lists = obj_battle_board.lists,
	_data;

for (var i = 0; i < array_length(_lists); i++) {
	_data = _lists[i];
	
	if (_data.type == BOARD_TYPE.CIRCLE){
		var _delta = _pos.copy().sub(_data.pos);
		var _size = _data.scale - collision_size;
		if (!point_in_circle(_delta.x, _delta.y, 0, 0, _size)){
			angle = 0;
			var _dir = point_direction(0, 0, _delta.x, _delta.y);
			_delta.set(lengthdir_x(_size, _dir), lengthdir_y(_size, _dir))
			_pos.set(_delta.add(_data.pos))
		}
		
	}
}

x = _pos.x;
y = _pos.y;