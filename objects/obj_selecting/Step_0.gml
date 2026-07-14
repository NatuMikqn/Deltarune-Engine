if (!disable) {
	var _row = input_check_pressed(INPUT.RIGHT) - input_check_pressed(INPUT.LEFT);
	var _column = input_check_pressed(INPUT.DOWN) - input_check_pressed(INPUT.UP);
	
	if (_row != 0) {
		// 現在のポイントの横移動
		// 縦については一致しているポイントか、-999であるポイントのみを対象とする
		// 現在のIDと同じである場合は無視
		var _point_x = now_point.x;
		var _next_x = infinity * _row;
		var _next_id;
		for (var i = 0; i < array_length(points); i++) {
			// 新しいのが来たら更新
			var _current_x = points[i][0].x;
			var _current_y = points[i][0].y;
			
			// yが-999ではなく、yが一致していなければ次へ
			if (_current_y != -999 && _current_y != now_point.y) {
				continue;
			}
			// xが-999なら次へ
			if (_current_x == -999) {
				continue;
			}
			
			// ポイント右移動
			if (_row == 1) {
				// 今のポイントから右であるかどうか
				// 候補のポイントより近いポイントであれば
				// 対象のポイントが-999でなければ
				if (
					_current_x > _point_x &&
					_current_x < _next_x
				) {
					_next_x = _current_x;
					_next_id = points[i][1];
				}
			} else
			// ポイント左移動
			if (_row == -1) {
				if (
					_current_x < _point_x &&
					_current_x > _next_x
				) {
					_next_x = _current_x;
					_next_id = points[i][1];
				}
			}
		}
		// 次のポイントが見つかっていれば更新
		if (!is_infinity(_next_x)) {
			now_point.x = _next_x;
			now_id = _next_id;
		}
	}
	
	if (_column != 0) {
		// 現在のポイントの縦移動
		// 横については一致しているポイントか、-999であるポイントのみを対象とする
		// 現在のIDと同じである場合は無視
		var _point_y = now_point.y;
		var _next_y = infinity * _column;
		var _next_id;
		for (var i = 0; i < array_length(points); i++) {
			// 新しいのが来たら更新
			var _current_x = points[i][0].x;
			var _current_y = points[i][0].y;
			
			// -999ではなく、xが一致していなければ次へ
			if (_current_x != -999 && _current_x != now_point.x) {
				continue;
			}
			// yが-999なら次へ
			if (_current_y == -999) {
				continue;
			}
			
			// ポイント下移動
			if (_column == 1) {
				// 今のポイントから下であるかどうか
				// 候補のポイントより近いポイントであれば
				if (
					_current_y > _point_y &&
					_current_y < _next_y
				) {
					_next_y = _current_y;
					_next_id = points[i][1];
				}
			} else
			// ポイント上移動
			if (_column == -1) {
				if (
					_current_y < _point_y &&
					_current_y > _next_y
				) {
					_next_y = _current_y;
					_next_id = points[i][1];
				}
			}
		}
		// 次のポイントが見つかっていれば更新
		if (!is_infinity(_next_y)) {
			now_point.y = _next_y;
			now_id = _next_id;
		}
	}
}