enum EASING_TWEEN{
	LINEAR = 0,
	SINE = 1,
	QUAD = 2,
	CUBIC = 3,
	QUART = 4,
	QUINT = 5,
	EXPO = 6,
	CIRC = 7,
	BACK = 8,
	ELASTIC = 9,
	BOUNCE = 10
}

enum EASING_EASE{
	IN = 0,
	OUT = 1,
	INOUT = 2
}

///初期化
///@ignore
function easing_init(){
	global.easing_data = [];
}

///内部用
///@ignore
function Easing() constructor{
	func = undefined;
	easing = undefined;
	stacks = [];
	value = 0;
	step = 0;
	mode = {
		target : false,
		loop : false,
		ignore : false,
	}
	
	tag = "";
	sleep = 0;
	
	timer = 0;
	call_stack = debug_get_callstack()
}

///イージングシーケンスを作成します
///@arg {Function} method
function EasingBuilder(_method) : Easing() constructor{
	
	func = _method;
	
	///TODO: startとset_valueの関係を見直す
	///@return {Struct.EasingBuilder}
	static start = function(_val){
		value = _val;
		return self;
	}
	
	///easingを追加します
	///@arg {real} tween
	///@arg {real} ease
	///@arg {real} change
	///@arg {real} duration
	///@return {Struct.EasingBuilder}
	static add_step = function(_tween, _ease, _change, _duration){
		array_push(stacks, [
			"easing",
			{
				tween : _tween,
				ease : _ease,
				change : _change,
				duration : _duration
			}
		])
		return self;
	}
	
	///@arg {real} value
	///@return {Struct.EasingBuilder}
	static set_value = function(_value){
		array_push(stacks, [
			"set",
			_value
		])
		return self;
	}
	
	///指定フレーム分休止します
	///@arg {real} sleep
	///@return {Struct.EasingBuilder}
	static add_sleep = function(_sleep){
		array_push(stacks, [
			"sleep",
			_sleep
		])
		return self;
	}
	
	///true: 目的地 false: 変更量
	///@arg {bool} enable
	///@return {Struct.EasingBuilder}
	static set_target = function(_enable){
		mode.target = _enable;
		return self;
	}
	
	///イージングが一通り終了した後、ループするかどうかを指定します
	///@return {Struct.EasingBuilder}
	static set_loop = function(_enable){
		mode.loop = _enable;
		return self;
	}
	
	//TODO: pauseは廃止予定
	///global.pauseを無視するかどうか
	///doesn't work!! 機能しません！！
	///@return {Struct.EasingBuilder}
	///@deprecated
	static set_ignore = function(_enable){
		mode.ignore = _enable;
		return self;
	}
	
	///Easingにタグをつけます
	///後にEasingを削除する際などに役立ちます
	///@return {Struct.EasingBuilder}
	static set_tag = function(_tag){
		tag = _tag;
		return self;
	}
	
	///自動でイージングを実行します
	static build = function(){
		var _data = new EasingData(self);
		if _data.get_next_type() != "sleep"{
			_data.func_call(value);
		}
		array_push(global.easing_data, _data);
	}
}

///内部用
///@ignore
function EasingData(_eb) : Easing() constructor{
	
	var _lists = variable_struct_get_names(self);
	
	array_foreach(_lists, method(_eb, function(_e){
		other[$_e] = self[$_e];
	}))
	
	///@pure
	static get_next_type = function(){
		return stacks[0][0];
	}
	
	static func_call = function(_value){
		method_call(func, [_value]);
	}
	
	///@arg {String}
	///@pure
	///@return {Bool}
	static check_tag = function(_tag){
		return (tag == _tag);
	}
	
	
}

///簡易版Easing
///@arg {Id.Instance} id
///@arg {String} varname
///@arg {Real} tween
///@arg {Real} ease
///@arg {Real} start
///@arg {Real} change
///@arg {Real} duration
///@arg {Real} delay
///@arg {String} tag
function easing_run(id, varname, tween, ease, start, change, duration, delay = 0, tag = ""){
	var _eb = new EasingBuilder(method({id, varname}, function (_v){
			variable_instance_set(id, varname, _v)
		}))
	_eb.start(start).add_sleep(delay).add_step(tween, ease, change, duration).set_tag(tag).build()
}

function easing_step(){
	var _list = global.easing_data,
		_data, _es, _array, _val, _delete
	
	_delete = []
	
	for(var i=0;i<array_length(_list);i++){
		
		_data = _list[i]
		
		with(_data){
			
			///////////////////////////////////
			/// debug - callstack
			
			/*show_debug_message("callstack------------------------------------")
			for(var j=0;j<array_length(_data.cs);j++){
				show_debug_message(_data.cs[j])
			}
			show_debug_message("---------------------------------------------")*/
			
			//sleep状態であれば、sleepタイマーを動かす
				if (sleep > 0){
				sleep--
			}
			//実行中のeasingがなければ
			else if (is_undefined(easing)){
				//次の行動は存在するかどうか
				if (array_length(stacks) > 0){
					switch (get_next_type()){
						case "easing":		//easing実行
							easing = array_shift(stacks)[1];
							timer = 0;
							if (mode.target) easing.change -= value
							break;
						case "set":			//value設定
							value = array_shift(stacks)[1];
							func_call(value);
							break;
						case "sleep":		//sleep実行
							sleep = array_shift(stacks)[1];
							break;
						default:
							show_debug_message("EASING ERROR - Incorrect type")
							array_push(_delete, i)
							continue;
					}
				}else{
					array_push(_delete, i)
					continue;
				}
			}
			
			//実行中のeasingがあれば
			if (is_struct(easing)){
				timer++;
				if (timer < easing.duration){	//実行中であるかどうか
					_val = value + easing.change * easing_get_value(easing.tween, easing.ease, timer / easing.duration);
					
					func_call(_val);
				}else{							//この行動の完了処理
					value += easing.change;
					func_call(value);
					easing = undefined;
				}
			}
		}
	}
	_delete = array_reverse(_delete)
	array_foreach(_delete, function(_e){
		array_delete(global.easing_data, _e, 1);
	});
}

///指定したタグのイージングシーケンスが存在するかどうか
///@arg {string} tag `set_tag()`で設定したタグ
///@return {bool}
function easing_exists(_tag){
	var _m = method({tag : _tag}, function(_val){ return (_val.tag == tag) })
	if array_any(global.easing_data, _m){
		return true;
	}
	return false;
}

//TODO: 完成させる
///指定したタグのイージングシーケンスをスキップします
///`easing_destroy()`とは違い、破棄時に最終的の位置まで移動させます
///@arg {string} tag
function easing_skip(_tag){
	var _list = global.easing_data;
	for(var i=0;i<array_length(_list);i++){
		if (_list[i].tag == _tag){
			method_call(_data.func, _array)
			/*try{
				var _array = [_es.start + _es.change * _value]
				method_call(_list[i].func, _array)
			}catch(_error){
				show_debug_message(_error)
			}*/
			array_delete(_list, i, 1)
			i--
		}
	}
}

///指定したタグのイージングシーケンスを破棄します
///使用しない場合、または部屋移動で利用されなくなる場合は、これを実行してください。
///`easing_skip()`とは違い、イージングの進捗は完全に停止されます
///@arg {string} tag `set_tag()`で設定したタグ
function easing_destroy(_tag){
	var _list = global.easing_data,
		_index_list = []
	
	//タグが一致するイージングシーケンスを探します
	for (var i=0;i<array_length(_list);i++){
		var _e = _list[i]
		if (_e.check_tag(_tag)) {
			array_push(_index_list, i);
		}
	}
	
	//削除します
	_index_list = array_reverse(_index_list);
	array_foreach(_index_list, function(_e){
		array_delete(global.easing_data, _e, 1);
	});
}

///イージングシーケンスを全部削除します
function easing_clear(){
	global.easing_data = []
}

///@arg {real} tween EASING_TWEEN.?
///@arg {real} ease EASING_EASE.?
///@arg {real} timer range in 0 to 1
///@return {real}
function easing_get_value(_tween,_ease,_t){
	switch(_tween){
		case 0: //Linear
			return _t;
		
		case 1: //Sine
			if _ease == 0 return 1 - dcos(_t * 90);
			if _ease == 1 return dsin(_t * 90);
			if _ease == 2 return -(dcos(_t * 90) - 1);
		
		case 2: //Quad
			if _ease == 0 return power(_t , 2);
			if _ease == 1 return 1 - power(1 - _t , 2);
			if _ease == 2 return _t < 0.5 ? 2 * power(_t , 2) : 1 - power(-2 * _t + 2 , 2) / 2;
		
		case 3: //Cubic
			if _ease == 0 return power(_t , 3);
			if _ease == 1 return 1 - power(1 - _t , 3);
			if _ease == 2 return _t < 0.5 ? 4 * power(_t , 3) : 1 - power(-2 * _t + 2 , 3) / 2;
		
		case 4: //Quart
			if _ease == 0 return power(_t , 4);
			if _ease == 1 return 1 - power(1 - _t , 4);
			if _ease == 2 return _t < 0.5 ? 8 * power(_t , 4) : 1 - power(-2 * _t + 2 , 4) / 2;
		
		case 5: //Quint
			if _ease == 0 return power(_t , 5);
			if _ease == 1 return 1 - power(1 - _t , 5);
			if _ease == 2 return _t < 0.5 ? 16 * power(_t , 5) : 1 - power(-2 * _t + 2 , 5) / 2;
		
		case 6: //Expo
			if _ease == 0 return _t == 0 ? 0 : power(2 , 10 * _t - 10);
			if _ease == 1 return _t == 1 ? 1 : 1 - power(2 , -10 * _t);
			if _ease == 2 return _t == 0 ? 0 : (_t == 1 ? 1 : (_t < 0.5 ? power(2 , 20 * _t - 10) / 2 : (2 - power(2 , -20 * _t + 10)) / 2));
		
		case 7: //Circ
			if _ease == 0 return 1 - sqrt(1 - power(_t, 2));
			if _ease == 1 return 1 - power(1 - _t, 5);
			if _ease == 2 return _t < 0.5 ? (1 - sqrt(1 - power(2 * _t, 2))) / 2 : (sqrt(1 - power(-2 * _t + 2, 2)) + 1) / 2;
		
		case 8: //Back
			var _c1 = 1.70158;
			var _c2 = _c1 * 1.525;
			var _c3 = _c1 + 1;
			if _ease == 0 return _c3 * power(_t, 3) - _c1 * power(_t, 2);
			if _ease == 1 return 1 + _c3 * power(_t - 1, 3) + _c1 * power(_t - 1, 2);
			if _ease == 2 return _t < 0.5 ? (power(2 * _t, 2) * ((_c2 + 1) * 2 * _t - _c2)) / 2 : (power(2 * _t - 2, 2) * ((_c2 + 1) * (_t * 2 - 2) + _c2) + 2) / 2;
		
		case 9: //Elastic
			var _c4 = (2 * pi) / 3;
			var _c5 = (2 * pi) / 4.5;
			if _ease == 0 return _t == 0 ? 0 : (_t == 1 ? 1 : -power(2, 10 * _t - 10) * sin((_t * 10 - 10.75) * _c4));
			if _ease == 1 return _t == 0 ? 0 : (_t == 1 ? 1 : power(2, -10 * _t) * sin((_t * 10 - 0.75) * _c4) + 1);
			if _ease == 2 return _t == 0 ? 0 : (_t == 1 ? 1 : (_t < 0.5 ? -(power(2, 20 * _t - 10) * sin((20 * _t - 11.125) * _c5)) / 2 : (power(2, -20 * _t + 10) * sin((20 * _t - 11.125) * _c5)) / 2 + 1));
		
		case 10: //Bounce
			
			if _ease == 0 return easing_get_value(_tween,_ease,1 - _t)
			if _ease == 1 {
				var _n1 = 7.5625;
				var _d1 = 2.75;
				var _c6
				if (_t < 1 / _d1) {
					_c6 = 0;
				} else if (_t < 2 / _d1) {
					_t -= 1.5 / _d1
					_c6 = 0.75;
				} else if (_t < 2.5 / _d1) {
					_t -= 2.25 / _d1
					_c6 = 0.9375;
				} else {
					_t -= 2.625 / _d1
					_c6 = 0.984375;
				}
				return _n1 * _t * _t + _c6;
			}
			if _ease == 2 return _t < 0.5 ? (1 - easing_get_value(_tween,_ease,1 - 2 * _t)) / 2 : (1 + easing_get_value(_tween,_ease,2 * _t - 1)) / 2;
		
	}
}