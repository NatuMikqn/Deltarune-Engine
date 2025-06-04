///@arg {real} x
///@arg {real} y
///@return {struct}
function vector2(_x = 0,_y = 0){
	return {x:_x,y:_y};
}

function vector2rot(_x = 0, _y = 0,_cx = 0, _cy = 0, _rot = 0){
	var _xx = _x - _cx
	var _yy = _y - _cy
	return {
		x : _cx + lengthdir_x(_xx,_rot) - lengthdir_y(_yy,_rot),
		y : _cy + lengthdir_x(_yy,_rot) + lengthdir_y(_xx,_rot)
	}
}

///@arg {real} x
///@arg {real} y
///@return {struct}
function vector2_camera(_x = 0,_y = 0){
	return {x:_x + obj_camera.every_x,y:_y + obj_camera.every_y};
}

///@arg {bool} enable
function alphafix(_bool){
	if _bool	gpu_set_blendmode_ext_sepalpha(bm_src_alpha,bm_inv_src_alpha,bm_one,bm_one);
	else		gpu_set_blendmode(bm_normal);
}

///@return {real}
function sur_get_app_width(){
	return surface_get_width(application_surface)
}
///@return {real}
function sur_get_app_height(){
	return surface_get_height(application_surface)
}

///@return {real}
function sur_c_x(){
	return sur_get_app_width() / 2
}
///@return {real}
function sur_c_y(){
	return sur_get_app_height() / 2
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

///@arg {real} align
function draw_set_align(_a){
	var _h = [fa_left, fa_center, fa_right]
	var _v = [fa_top, fa_middle, fa_bottom]
	draw_set_halign(_h[_a % 3])
	draw_set_valign(_v[_a div 3])
}

///@return {Id.Surface}
function surface_create_auto(){
	var _w = sur_get_app_width();
	var _h = sur_get_app_height();
	return surface_create(_w,_h);
}

///@arg {real} value
///@arg {real} s1
///@arg {real} s2
///@arg {real} r1
///@arg {real} r2
function map_value(_value,_s1,_s2,_r1,_r2){
	var _a = (_s2 + _value) / (_s2 - _s1);
	return lerp(_r1, _r2, _a)
}

///@arg {Constant.Color} color
///@arg {Real} alpha
function draw_set_ca(_color = c_white,_alpha = 1){
	draw_set_color(_color)
	draw_set_alpha(_alpha)
}

///@arg {array} array
///@return {bool}
function array_empty(_array){
	return (array_length(_array) == 0)
}

///@arg {real} percent
///@return {bool}
function chance(_p){
	return (random(1) < (_p / 100))
}

///@arg {array} array
///@arg {real} value
///@return {bool}
function array_exists(_array, _value){
	return (array_length(_array) > _value) && (!is_undefined(_array[_value]))
}

///@arg {Id.Instance} instance
///@arg {Asset.GMObject} object
///@return {bool}
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
