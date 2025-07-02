
///@arg {bool} enable
function alphafix(_bool){
	if _bool	gpu_set_blendmode_ext_sepalpha(bm_src_alpha,bm_inv_src_alpha,bm_one,bm_one);
	else		gpu_set_blendmode(bm_normal);
}

///@arg {real} x
///@arg {real} y
///@arg {real} string
function draw_text_shadow(_x,_y,_string){
	draw_text_transformed_shadow(_x,_y,_string,1,1,0)
}

///@arg {real} x
///@arg {real} y
///@arg {real} string
///@arg {real} xscale
///@arg {real} yscale
///@arg {real} angle
function draw_text_transformed_shadow(_x,_y,_string,_xscale,_yscale,_angle){
	var _color = draw_get_color()
	draw_set_color(c_black)
	draw_text_transformed(_x+_xscale,_y+_yscale,_string,_xscale,_yscale,_angle)
	draw_set_color(_color)
	draw_text_transformed(_x,_y,_string,_xscale,_yscale,_angle)
}

///@arg {real} x
///@arg {real} y
///@arg {real} string
///@arg {real} xscale
///@arg {real} yscale
///@arg {real} angle
function draw_text_transformed_outline(_x,_y,_string,_xscale,_yscale,_angle){
	var _color = draw_get_color()
	draw_set_color(c_black)
	for(var i=0;i<9;i++){
		if i != 4{
			draw_text_transformed(_x+((i%3)-1)*_xscale,_y+(floor(i/3)-1)*_yscale,_string,_xscale,_yscale,_angle)
		}
	}
	draw_set_color(_color)
	draw_text_transformed(_x,_y,_string,_xscale,_yscale,_angle)
}

///@arg {Asset.GMSprite} sprite
///@arg {real} subimg
///@return {real}
function sprtex_get_width(_sprite,_subimg){
	var _uvs = sprite_get_uvs(_sprite, _subimg);
	var _tex = sprite_get_texture(_sprite, _subimg);
	var _tw = texture_get_texel_width(_tex);
	var _wdt = (_uvs[2] - _uvs[0]) / _tw;
	return _wdt;
}

///@arg {Asset.GMSprite} sprite
///@arg {real} subimg
///@return {real}
function sprtex_get_height(_sprite,_subimg){
	var _uvs = sprite_get_uvs(_sprite, _subimg);
	var _tex = sprite_get_texture(_sprite, _subimg);
	var _th = texture_get_texel_height(_tex);
	var _hgt = (_uvs[3] - _uvs[1]) / _th;
	return _hgt;
}

/// [ 0, 1, 2 ]
/// [ 3, 4, 5 ]
/// [ 6, 7, 8 ]
///@arg {real} align 入れるべき値はこの関数の説明を参照してください
function draw_set_align(_a){
	var _h = [fa_left, fa_center, fa_right]
	var _v = [fa_top, fa_middle, fa_bottom]
	draw_set_halign(_h[_a % 3])
	draw_set_valign(_v[_a div 3])
}

///@desc s1~s2の範囲からr1~r2の範囲へvalueを再マップします
///@arg {real} value 再マップ対象
///@arg {real} s1 ある範囲からのx~
///@arg {real} s2 ある範囲からの~x
///@arg {real} r1 ある範囲までのx~
///@arg {real} r2 ある範囲までの~x
///@pure
function map_value(_value, _s1, _s2, _r1, _r2){
	var _a = (_value - _s1) / (_s2 - _s1);
	return lerp(_r1, _r2, _a)
}

///@desc draw_set_colorとdraw_set_alphaを合わせたものです
///@arg {Constant.Color} color
///@arg {Real} alpha
function draw_set_ca(_color = c_white,_alpha = 1){
	draw_set_color(_color)
	draw_set_alpha(_alpha)
}

///@desc 配列が空であるかどうか
///@arg {array} array
///@return {bool}
///@pure
function array_empty(_array){
	return (array_length(_array) == 0)
}

///@desc 指定した%の確率で真を返します
///@arg {real} percent
///@return {bool}
///@pure
function chance(_p){
	return (random(1) < (_p / 100))
}

///@arg {array} array
///@arg {real} value
///@return {bool}
///@pure
function array_exists(_array, _value){
	return (array_length(_array) > _value) && (!is_undefined(_array[_value]))
}

///@arg {Id.Instance} instance
///@arg {Asset.GMObject} object
///@return {bool}
///@pure
function instance_parent_equals(_id, _object){
	if (_id.object_index == _object)						return true;
	if (object_get_parent(_id.object_index) == _object)		return true;
	
	return false;
}

///@arg {String} char
///@arg {String} search
///@return {Bool}
function string_char_contains(char, search){
	var _char;
	for (var i = 1; i <= string_length(search); i++) {
		_char = string_char_at(search, i);
		if (char == _char) return true;
	}
	return false;
}

///aからbまでの範囲にxが含まれるかどうか
///含まれていれば、Trueを返します。
///@arg {Real} x 数値
///@arg {Real} a から
///@arg {Real} b まで
///@return {Bool} 含まれているかどうか
///@pure
function in_range(_x, _a, _b){
	return (_a <= _x) && (_x <= _b);
}

///画面サイズを設定します
///@arg {Real} width
///@arg {Real} height
function screen_size(_w, _h){
	window_set_size(_w, _h)
	surface_resize(application_surface, _w, _h)
	window_center()
}

///JSONを読み込み、ネストされた配列構造体を返します
///@arg {String} path
///@return {Any}
function json_load(_path){
	
	var _file = file_text_open_read(_path)
	var _json = "";
		while (!file_text_eof(_file)){
		_json += file_text_read_string(_file);
		file_text_readln(_file);
	}
	
	var _return = json_parse(_json);
	file_text_close(_file);
	
	return _return;
}
