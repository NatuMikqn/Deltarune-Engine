///@desc 二次元ベクトルを返します
///@arg {Real} x
///@arg {Real} y
///@return {Struct.Vector2}
function Vector2(_x = 0, _y = _x) constructor {
	x = _x;
	y = _y;
	
	///@desc (0, 0)
	///@return {Struct.Vector2}
	static zero = function(){
		x = 0;
		y = 0;
		return self;
	}
	
	///@desc (1, 1)
	///@return {Struct.Vector2}
	static one = function(){
		x = 1;
		y = 1;
		return self;
	}
	
	///@desc (1, 0)
	///@return {Struct.Vector2}
	static unit_x = function(){
		x = 1;
		y = 0;
		return self;
	}
	
	///@desc (0, 1)
	///@return {Struct.Vector2}
	static unit_y = function(){
		x = 0;
		y = 1;
		return self;
	}
	
	///@desc このvec2に値を設定します
	///返り値はこのvec2です
	///@arg {Struct.Vector2,Real} x
	///@arg {Real} y
	///@return {Struct.Vector2}
	static set = function(_x, _y = _x){
		if is_struct(_x){
			x = _x.x;
			y = _x.y;
		}else if is_real(_x){
			x = _x;
			y = _y;
		}
		return self;
	}
	
	///@desc このvec2に値を加算します
	///返り値はこのvec2です
	///@arg {Struct.Vector2,Real} x
	///@arg {Real} y
	///@return {Struct.Vector2}
	static add = function(_x, _y = _x){
		if is_struct(_x){
			x += _x.x;
			y += _x.y;
		}else if is_real(_x){
			x += _x;
			y += _y;
		}
		return self;
	}
	
	///@desc このvec2から値を減算します
	///返り値はこのvec2です
	///@arg {Struct.Vector2,Real} x
	///@arg {Real} y
	///@return {Struct.Vector2}
	static sub = function(_x, _y = _x){
		if is_struct(_x){
			x -= _x.x;
			y -= _x.y;
		}else if is_real(_x){
			x -= _x;
			y -= _y;
		}
		return self;
	}
	
	///@desc このvec2と値を乗算します
	///返り値はこのvec2です
	///@arg {Struct.Vector2,Real} x
	///@arg {Real} y
	///@return {Struct.Vector2}
	static mul = function(_x, _y = _x){
		if is_struct(_x){
			x *= _x.x;
			y *= _x.y;
		}else if is_real(_x){
			x *= _x;
			y *= _y;
		}
		return self;
	}
	
	///@desc このvec2を値で除算します
	///返り値はこのvec2です
	///@arg {Struct.Vector2,Real} x
	///@arg {Real} y
	///@return {Struct.Vector2}
	static divide = function(_x, _y = _x){
		if is_struct(_x){
			x /= _x.x;
			y /= _x.y;
		}else if is_real(_x){
			x /= _x;
			y /= _y;
		}
		return self;
	}
	
	///@desc 商を求めます
	///@arg {Struct.Vector2,Real} x
	///@arg {Real} y
	///@return {Struct.Vector2}
	static q = function(_x, _y = _x){
		if is_struct(_x){
			x = x div _x.x;
			y = y div _x.y;
		}else if is_real(_x){
			x = x div _x;
			y = y div _y;
		}
		return self;
	}
	
	///@desc このvec2から値で余りを出します
	///返り値はこのvec2です
	///@arg {Struct.Vector2,Real} x
	///@arg {Real} y
	///@return {Struct.Vector2}
	static modulo = function(_x, _y = _x){
		if is_struct(_x){
			x %= _x.x;
			y %= _x.y;
		}else if is_real(_x){
			x %= _x;
			y %= _y;
		}
		return self;
	}
	
	///@desc 2つのvec2の値が同じであるかどうか
	///@arg {Struct.Vector2,Real} x
	///@arg {Real} y
	///@return {Bool}
	static equals = function(_x, _y = _x){
		if is_struct(_x){
			return (x == _x.x && y == _x.y);
		}else if is_real(_x){
			return (x == _x && y == _y);
		}
		return false;
	}
	
	///@desc 二つの値を絶対値にかけます
	///@return {Struct.Vector2}
	static apply_abs = function(){
		x = abs(x)
		y = abs(y)
		return self;
	}
	
	///@desc vec2をコピーしたものを返します
	///@return {Struct.Vector2}
	static copy = function(){
		return new Vector2(x, y);
	}
	
	///@desc (0,0)位置を中心に回転行列を行います
	///@arg {Real} rot
	///@return {Struct.Vector2}
	static rot = function(rot){
		var _x = x;
		x = lengthdir_x(x,rot) - lengthdir_y(y,rot);
		y = lengthdir_x(y,rot) + lengthdir_y(_x,rot);
		return self;
	}
	
	///@desc ベクトルの正規化を行います
	///@return {Struct.Vector2}
	static normalize = function(){
		
		var _len = sqrt(sqr(x) + sqr(y));
		x /= _len;
		y /= _len;
		return self;
	}
	
	///@desc 距離を求めます
	///@arg {Struct.Vector2|Real} x
	///@arg {Real} y
	///@return {Real}
	static distance = function(_x = 0, _y = _x){
		if is_struct(_x){
			return point_distance(x, y, _x.x, _x.y);
		}else if is_real(_x){
			return point_distance(x, y, _x, _y);
		}
		return 0;
	}
	
	///@desc 角度を求めます
	///@arg {Struct.Vector2|Real} x
	///@arg {Real} y
	///@return {Real}
	static dir = function(_x = 0, _y = _x){
		if is_struct(_x){
			return point_direction(x, y, _x.x, _x.y);
		}else if is_real(_x){
			return point_direction(x, y, _x, _y);
		}
		return 0;
	}
	
	///@desc XY値を大きい方の値に設定します
	///@return {Real}
	static max = function(){
		var _max = max(x, y);
		x = _max;
		y = _max;
	}
	
	///@desc XY値を小さい方の値に設定します
	///@return {Real}
	static min = function(){
		var _min = min(x, y);
		x = _min;
		y = _min;
	}
	
	///@desc 大きい方の値を返します
	///@return {Real}
	static get_max = function(){ return max(x, y); }
	
	///@desc 小さい方の値を返します
	///@return {Real}
	static get_min = function(){ return min(x, y); }
	
	///@desc 内積を求めます
	///@arg {Struct.Vector2} vec2
	///@return {Real}
	static dot = function(vec2){ return x * vec2.x + y * vec2.y; }
	
	///@desc 外積を求めます
	///@arg {Struct.Vector2} vec2
	///@return {Real}
	static cross = function(vec2){ return x * vec2.y - y * vec2.x; }
}