
///@return {Id.Surface}
///@pure
function surface_create_auto(){
	var _w = surface_get_app_width();
	var _h = surface_get_app_height();
	return surface_create(_w,_h);
}

///@desc surfaceの初期化
///@arg {String} surfacename
///@arg {Real} x
///@arg {Real} y
function surface_check(_name, _w = surface_get_app_width(), _h = surface_get_app_height()){
	//既に存在していればなにもしない
	if (!variable_instance_exists(id, _name)) return;
	var _srf = variable_instance_get(id, _name)
	if (surface_exists(_srf)) return;
	
	var _surface = surface_create(_w, _h);
	variable_instance_set(id, _name, _surface)
}

///@desc surfaceの画面をまっさらにする
///@arg {Id.Surface} surface
function draw_clear_surface(_surface){
	surface_set_target(_surface)
	draw_clear_alpha(c_black, 0)
	surface_reset_target()
}


///SpriteをSurfaceに変換します
///@arg {Asset.GMSprite} sprite Asset.GMSprite
///@arg {Real} subimg Real
///@return {Id.Surface} Id.Sprite
function surface_create_from_sprite(_spr, _img = 0){
	var _return = surface_create(sprite_get_width(_spr), sprite_get_height(_spr))
	surface_set_target(_return)
	draw_sprite(_spr, _img, sprite_get_xoffset(_spr), sprite_get_yoffset(_spr))
	surface_reset_target()
	return _return;
}

///@return {real}
function surface_get_app_width(){
	return surface_get_width(application_surface)
}
///@return {real}
function surface_get_app_height(){
	return surface_get_height(application_surface)
}

/// @arg {Asset.GMSprite} spr
/// @arg {Real} img
/// @return {Struct.Vector2}
function sprite_get_texel_size(_spr, _img = 0) {
	var _tex = sprite_get_texture(_spr, _img);
	return texture_get_texel_size(_tex);
}

/// @arg {Id.Surface} srf
/// @return {Struct.Vector2}
function surface_get_texel_size(_srf) {
	var _tex = surface_get_texture(_srf);
	return texture_get_texel_size(_tex);
}

/// @arg {Pointer.Texture} tex
/// @return {Struct.Vector2}
function texture_get_texel_size(_tex) {
	var _vec2 = new Vector2();
	_vec2.x = texture_get_texel_width(_tex);
	_vec2.y = texture_get_texel_height(_tex);
	return _vec2;
}