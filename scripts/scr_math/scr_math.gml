/// jtmiter by clipper
///@arg {Array<Struct.Vector2>} poly
///@arg {Real|Struct.Vector2} offset
///@arg {Bool} ccw
///@return {Array<Struct.Vector2>}
function offset_point_jtmiter(poly, offset, ccw){
	
	//offset値が0なら変える必要ないのでコピーを返す
	if (is_real(offset)){
		if (offset == 0) return variable_clone(poly);
	}else if (is_struct(offset)){
		if (offset.equals(0)) return variable_clone(poly);
	}else throw "The 'offset' argument in offset_point_jtmiter() must be either a Real or a Struct.Vector2"
	
	var _count = array_length(poly);
	
	//各ポリゴン位置を保存する場所
	var _sel;
	
	var _n = [], _o = [];
	
	var _miter, _dot, _len, _new;
	
	var _return = [], _continue;
	
	var i, j;
	
	for (i = 0; i < _count; i++) {
		_sel[0] = poly[(i + _count - 1) % _count];
		_sel[1] = poly[i];
		_sel[2] = poly[(i + 1) % _count];
		
		//現在の線とひとつ前の線を単位ベクトル化
		for (j = 0; j < 2; j++) {
			_n[j] = new Vector2(_sel[j + 1].x - _sel[j].x, _sel[j + 1].y - _sel[j].y)
			_n[j].normalize();
			
			//90度回転
			_o[j] = new Vector2(_n[j].y, -_n[j].x);
			if (ccw) _o[j].mul(-1);
		}
		
		//miter
		_miter = new Vector2(_o[0].x + _o[1].x, _o[0].y + _o[1].y);
		_miter.normalize();
		
		//miterと90度回転した単位ベクトルの内積を求める
		_dot = _miter.dot(_o[1]);
		if (_dot == 0) _dot = 0.0001;
		
		//長さを求める
		if (is_real(offset)){
			_len = offset / _dot;
		}else if (is_struct(offset)){
			_len = offset.copy().divide(_dot);
		}
		
		
		//元ポリゴンから座標をずらす
		_new = _sel[1].copy().add(_miter.copy().mul(_len));
		array_push(_return, _new)
	}
	return _return;
}

///ポリゴンは反時計回りであるかどうか
///@arg {Array<Struct.Vector2>} polydata
///@return {Bool}
///@pure
function polygon_is_ccw(polydata){
	var _count = array_length(polydata), _sel = [], _total = 0;
	
	//合計結果が正であれば正転
	//合計結果が負であれば逆転
	for (var i = 0; i < _count; i++) {
		_sel[0] = polydata[i];
		_sel[1] = polydata[(i + 1) % _count];
		
		_total += _sel[0].cross(_sel[1]);
	}
	
	return (_total < 0);
}

///耳であるかどうか
///Board用に設計されています
///@arg {Real} pos
///@arg {Array<Struct.Vector2>} polydata
///@arg {Array<Struct.Vector2>} points
///@arg {Bool} ccw
///@return {Bool}
///@pure
function in_ear(pos, polydata, points, ccw){
	var _len = array_length(polydata);
	var _prev = (pos - 1 + _len) % _len
	var _next = (pos + 1) % _len
	
	//三角形が逆回りの場合false
	var _d1 = points[1].copy().sub(points[0]);
	var _d2 = points[2].copy().sub(points[1]);
	
	if ((_d1.cross(_d2) * (1 - ccw * 2) < 0)) return false;
	
	for (var i = 0; i < _len; i++) {
		if (_prev != i && pos != i && _next != i){
			if (point_in_triangle(
				polydata[i].x, polydata[i].y,
				points[0].x, points[0].y,
				points[1].x, points[1].y,
				points[2].x, points[2].y
			)) return false;
		}
	}
	return true;
}

///楕円判定
///@arg {Real} x x座標
///@arg {Real} y y座標
///@arg {Real} cx 楕円x座標
///@arg {Real} cy 楕円y座標
///@arg {Real} sx xscale
///@arg {Real} sy yscale
///@arg {Real} angle 楕円の角度
///@return {Bool}
///@pure
function point_in_ellipse(x, y, cx, cy, sx, sy, angle){
	var _delta = new Vector2(x - cx, y - cy);
	_delta.rot(-angle);
	var _val = (sqr(_delta.x) / sqr(sx) + sqr(_delta.y) / sqr(sy));
	return (_val <= 1);
}