//enum EASING_TWEEN{
	//LINEAR = 0,
	//SINE = 1,
	//QUAD = 2,
	//CUBIC = 3,
	//QUART = 4,
	//QUINT = 5,
	//EXPO = 6,
	//CIRC = 7,
	//BACK = 8,
	//ELASTIC = 9,
	//BOUNCE = 10
//}
//
//enum EASING_EASE{
	//IN = 0,
	//OUT = 1,
	//INOUT = 2
//}
//
//function easing_init(){
	//global.easing_data = [];
//}
//
/////@arg {real} tween
/////@arg {real} ease
/////@arg {real} duration
/////@arg {real} delay
/////@arg {real} start
/////@arg {real} change
/////@arg {bool} target
//function EaseState(_tween, _ease, _duration, _delay = 0, _start = 0, _change = 1, _target = false) constructor{
	//tween = _tween;
	//ease = _ease;
	//start = _start;
	//change = _change - _start * _target;
	//duration = _duration;
	//delay = _delay;
	//timer = 0;
//}
//
/////@arg {function} method
/////@arg {string} tag
/////@arg {bool} ingore
/////@arg {array<struct>} easestate
//function easing_create(_method, _tag, _ingore, _easestate){
	//var _data = {
		//func : _method,
		//ignore : _ingore,
		//es : _easestate,
		//tag : _tag,
		//step : 0,
		//cs : debug_get_callstack()
	//}
	//if _data.es[0].delay == 0{
		//method_call(_data.func, [_data.es[0].start])
	//}
	//array_push(global.easing_data, _data);
//}
//
/////@arg {function} method
/////@arg {string} tag
/////@arg {bool} stop_ingore
/////@arg {real} delay
//function delay_create(_method, _tag, _stopingore, _delay){
	//var _es = new EaseState(0, 0, 0, _delay);
	//easing_create(_method, _tag, _stopingore, [_es])
	//return _es;
//}
//
//function easing_step(){
	//var _list = global.easing_data,
		//_data, _es, _array, _value, _delete
	//for(var i=0;i<array_length(_list);i++){
		//_data = _list[i]
		///*show_debug_message("callstack------------------------------------")
		//for(var j=0;j<array_length(_data.cs);j++){
			//show_debug_message(_data.cs[j])
		//}
		//show_debug_message("---------------------------------------------")*/
		//_es = _data.es[0]
		//if (!_data.ignore && !is_paused()) || (_data.ignore){
			//if _es.delay <= 0{
				//_es.timer++
				//_delete = false
				//_value = easing_get_value(_es.tween, _es.ease, _es.timer / _es.duration)
				//_array = [_es.start + _es.change * _value, _data.step]		//array_concat([_es.start + _es.change * _value], _data.args)
				//method_call(_data.func, _array)
				///*try{
					//method_call(_data.func, _array)
				//}catch(_error){
					//show_debug_message(_error)
					//_delete = true
				//}*/
				//if (_es.timer >= _es.duration) || _delete{
					//array_delete(_data.es, 0, 1)
					//_data.step++
					//if array_length(_data.es) == 0{
						//array_delete(_list, i, 1)
						//i--
					//}
				//}
			//}
			//else{
				//_es.delay--
			//}
		//}
	//}
//}
//
/////@arg {string} tag
/////@return {bool}
//function easing_exists(_tag){
	//var _m = method({tag : _tag}, function(_val){ return (_val.tag == tag) })
	//if array_any(global.easing_data, _m){
		//return true;
	//}
	//return false;
//}
//
/////@arg {string} tag
//function easing_skip(_tag){
	//var _list = global.easing_data;
	//for(var i=0;i<array_length(_list);i++){
		//if (_list[i].tag == _tag){
			//method_call(_data.func, _array)
			///*try{
				//var _array = [_es.start + _es.change * _value]
				//method_call(_list[i].func, _array)
			//}catch(_error){
				//show_debug_message(_error)
			//}*/
			//array_delete(_list, i, 1)
			//i--
		//}
	//}
//}
//
/////@arg {string} tag
//function easing_destroy(_tag){
	//var _list = global.easing_data;
	//for(var i=0;i<array_length(_list);i++){
		//if (_list[i].tag == _tag){
			//array_delete(_list, i, 1)
			//i--
		//}
	//}
//}
//
//function easing_clear(){
	//global.easing_data = []
//}
//
/////@arg {real} tween
/////@arg {real} ease
/////@arg {real} timer
/////@return {real}
//function easing_get_value(_tween,_ease,_t){
	//switch(_tween){
		//case 0: //Linear
			//return _t;
		//
		//case 1: //Sine
			//if _ease == 0 return 1 - dcos(_t * 90);
			//if _ease == 1 return dsin(_t * 90);
			//if _ease == 2 return -(dcos(_t * 90) - 1);
		//
		//case 2: // Quad
			//if _ease == 0 return power(_t , 2);
			//if _ease == 1 return 1 - power(1 - _t , 2);
			//if _ease == 2 return _t < 0.5 ? 2 * power(_t , 2) : 1 - power(-2 * _t + 2 , 2) / 2;
		//
		//case 3: //Cubic
			//if _ease == 0 return power(_t , 3);
			//if _ease == 1 return 1 - power(1 - _t , 3);
			//if _ease == 2 return _t < 0.5 ? 4 * power(_t , 3) : 1 - power(-2 * _t + 2 , 3) / 2;
		//
		//case 4: //Quart
			//if _ease == 0 return power(_t , 4);
			//if _ease == 1 return 1 - power(1 - _t , 4);
			//if _ease == 2 return _t < 0.5 ? 8 * power(_t , 4) : 1 - power(-2 * _t + 2 , 4) / 2;
		//
		//case 5: //Quint
			//if _ease == 0 return power(_t , 5);
			//if _ease == 1 return 1 - power(1 - _t , 5);
			//if _ease == 2 return _t < 0.5 ? 16 * power(_t , 5) : 1 - power(-2 * _t + 2 , 5) / 2;
		//
		//case 6: //Expo
			//if _ease == 0 return _t == 0 ? 0 : power(2 , 10 * _t - 10);
			//if _ease == 1 return _t == 1 ? 1 : 1 - power(2 , -10 * _t);
			//if _ease == 2 return _t == 0 ? 0 : (_t == 1 ? 1 : (_t < 0.5 ? power(2 , 20 * _t - 10) / 2 : (2 - power(2 , -20 * _t + 10)) / 2));
		//
		//case 7: //Circ
			//if _ease == 0 return 1 - sqrt(1 - power(_t, 2));
			//if _ease == 1 return 1 - power(1 - _t, 5);
			//if _ease == 2 return _t < 0.5 ? (1 - sqrt(1 - power(2 * _t, 2))) / 2 : (sqrt(1 - power(-2 * _t + 2, 2)) + 1) / 2;
		//
		//case 8: //Back
			//var _c1 = 1.70158;
			//var _c2 = _c1 * 1.525;
			//var _c3 = _c1 + 1;
			//if _ease == 0 return _c3 * power(_t, 3) - _c1 * power(_t, 2);
			//if _ease == 1 return 1 + _c3 * power(_t - 1, 3) + _c1 * power(_t - 1, 2);
			//if _ease == 2 return _t < 0.5 ? (power(2 * _t, 2) * ((_c2 + 1) * 2 * _t - _c2)) / 2 : (power(2 * _t - 2, 2) * ((_c2 + 1) * (_t * 2 - 2) + _c2) + 2) / 2;
		//
		//case 9: //Elastic
			//var _c4 = (2 * pi) / 3;
			//var _c5 = (2 * pi) / 4.5;
			//if _ease == 0 return _t == 0 ? 0 : (_t == 1 ? 1 : -power(2, 10 * _t - 10) * sin((_t * 10 - 10.75) * _c4));
			//if _ease == 1 return _t == 0 ? 0 : (_t == 1 ? 1 : power(2, -10 * _t) * sin((_t * 10 - 0.75) * _c4) + 1);
			//if _ease == 2 return _t == 0 ? 0 : (_t == 1 ? 1 : (_t < 0.5 ? -(power(2, 20 * _t - 10) * sin((20 * _t - 11.125) * _c5)) / 2 : (power(2, -20 * _t + 10) * sin((20 * _t - 11.125) * _c5)) / 2 + 1));
		//
		//case 10: //Bounce
//
			//if _ease == 0 return easing_get_value(_tween,_ease,1 - _t)
			//if _ease == 1 {
				//var _n1 = 7.5625;
				//var _d1 = 2.75;
				//var _c6
				//if (_t < 1 / _d1) {
					//_c6 = 0;
				//} else if (_t < 2 / _d1) {
					//_t -= 1.5 / _d1
					//_c6 = 0.75;
				//} else if (_t < 2.5 / _d1) {
					//_t -= 2.25 / _d1
					//_c6 = 0.9375;
				//} else {
					//_t -= 2.625 / _d1
					//_c6 = 0.984375;
				//}
				//return _n1 * _t * _t + _c6;
			//}
			//if _ease == 2 return _t < 0.5 ? (1 - easing_get_value(_tween,_ease,1 - 2 * _t)) / 2 : (1 + easing_get_value(_tween,_ease,2 * _t - 1)) / 2;
		//
	//}
//}