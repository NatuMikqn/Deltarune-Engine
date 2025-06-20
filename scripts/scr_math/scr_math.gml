/// jtmiter by clipper
///@arg {Array<Struct.Vector2>} poly
///@arg {Real} offset
///@return {Array<Struct.Vector2>}
function offset_point_jtmiter(poly, offset){
	var _count = array_length(poly);
	
	//各ポリゴン位置を保存する場所
	var _sel;
	
	var _n = [], _o = [];
	
	var _miter, _dot, _len, _new;
	
	var _return = [];
	
	var _total = 0;
	
	var i, j;
	
	for (i = 0; i < _count; i++) {
		_sel[0] = poly[i];
		_sel[1] = poly[(i + 1) % _count];
		
		_total += _sel[0].x * _sel[1].y - _sel[1].x * _sel[0].y;
	}
	
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
			_o[j].mul(sign(_total));
		}
		
		//miter
		_miter = new Vector2(_o[0].x + _o[1].x, _o[0].y + _o[1].y);
		_miter.normalize();
		
		//miterと90度回転した単位ベクトルの内積を求める
		_dot = _miter.dot(_o[1]);
		if (_dot == 0) _dot = 0.0001;
		
		//長さを求める
		_len = offset / _dot;
		
		//元ポリゴンから座標をずらす
		_new = _sel[1].copy().add(_miter.copy().mul(_len));
		array_push(_return, _new)
	}
	return _return;
}