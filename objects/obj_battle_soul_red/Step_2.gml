var _spd = spd - (input_check(INPUT.CANCEL) * 0.5)
var _pos = new Vector2();

if (movable){
	hsp = input_check(INPUT.RIGHT) - input_check(INPUT.LEFT);
	vsp = input_check(INPUT.DOWN) - input_check(INPUT.UP);
}
_pos = new Vector2(x + hsp * _spd, y + vsp * _spd);

if (hitbox){
	var _lists = obj_battle_board.lists,
		_data;
	
	for (var i = 0; i < array_length(_lists); i++) {
		_data = _lists[i];
		var _delta = _pos.copy().sub(_data.pos);
		
		if (_data.type == BOARD_TYPE.POLYGON){
			var _hb = variable_clone(_data.polyhitbox),
				_len = array_length(_hb),
				_point = [],
				_nearlen = infinity,
				_neartemp = 0,
				_nearpos = -1,
				_heart_count = 0;
			
			for (var j = 0; j < array_length(_hb); j++) {
				_hb[j].rot(obj_battle_board.angle)
			}
			
			//TODO コードの改善 変数名やコードを使いまわせる箇所を探す(.copy()数を減らす)
			for (var j = 0; j < _len; j++) {
				_point[0] = _hb[j].copy();
				_point[1] = _hb[(j + 1) % _len].copy();
				
				var _ab = _point[1].sub(_point[0])
				var _ap = _delta.copy().sub(_point[0])
				
				var _t = clamp(_ap.dot(_ab) / _ab.copy().dot(_ab), 0, 1);
				
				var _final = _point[0].add(_ab.mul(_t));
				
				_neartemp = _delta.distance(_final);
				
				//ソウルから一番近いポリゴンの線分を取得する
				if (_neartemp < _nearlen){
					_nearlen = _neartemp;
					_nearpos = _final;
				}
				
				_point[0] = _hb[j].copy();
				_point[1] = _hb[(j + 1) % _len].copy();
				
				//ポリゴン線分の２点y座標が、ソウルのy座標内であれば
				if ((_point[0].y > _delta.y) != (_point[1].y > _delta.y)){
					
					//ソウルのy座標からのy座標の位置を0~1に再マップ
					var _amt = map_value(_delta.y, _point[0].y, _point[1].y, 0, 1)
					
					var _intersect = lerp(_point[0].x, _point[1].x, _amt)
					
					if (_delta.x < _intersect){
						_heart_count++;
					}
				}
			}
			
			if ((_heart_count % 2) == 0){
				_pos.set(_nearpos.add(_data.pos));
			}
		}
		
		if (_data.type == BOARD_TYPE.CIRCLE){
			var _size = collision_size.copy().mul(-1).add(_data.scale);
			if (!point_in_circle(_delta.x, _delta.y, 0, 0, _size.x)){
				angle = 0;
				var _dir = point_direction(0, 0, _delta.x, _delta.y);
				_delta.set(lengthdir_x(_size.x, _dir), lengthdir_y(_size.y, _dir))
				_pos.set(_delta.add(_data.pos))
			}
			
		}
	}
}

x = _pos.x;
y = _pos.y;