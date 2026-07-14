points = [];

/// 現在の位置
now_point = new Vector2();
now_id = -1;

disable = false;

/// @arg {Real} row -999なら横の値を無視
/// @arg {Real} column -999なら縦の値を無視
/// @arg {Real} point_id ID
function add_point(row, column, point_id) {
	array_push(points, [new Vector2(row, column), point_id]);
}

/// @arg {Real} point_id ID
function finish_setup(point_id) {
	var _index = array_find_index(points, method({ point_id }, function (_element, _index) {
		return (_element[1] == point_id);
	}));
	if (_index < 0) {
		// TODO: 例外文を考える
		throw "a";
	} else {
		now_point.x = points[_index][0].x;
		if (now_point.x == -999) now_point.x = 0;
		
		now_point.y = points[_index][0].y;
		if (now_point.y == -999) now_point.y = 0;
		
		now_id = points[_index][1];
	}
}