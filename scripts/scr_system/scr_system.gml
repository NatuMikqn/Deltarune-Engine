///IDEから実行されているかどうかを確認します
///@return {bool}
///@pure
function is_test()
{
	return (GM_build_type == "run");
}

///@arg {real} width
///@arg {real} height
function screen_set_size(_w, _h)
{
	obj_camera.scale.x = 1
	obj_camera.scale.y = 1
	window_set_size(_w, _h)
}

///開始からの経過フレームを返します
///@return {Real}
function get_worldtimer()
{
	return obj_system.timer;
}

///Builderの変数群から基盤のみ存在する変数をDataへ移行する
function send_builder_to_data(_builder)
{
	var _lists = variable_struct_get_names(self);
	
	array_foreach(_lists, method(_builder, function(_e){
		other[$_e] = self[$_e];
	}))
}

///デフォルトのスクリーンサイズのコピーvec2を取得
///@return {Struct.Vector2}
function get_default_screensize()
{
	return obj_screen.screen_size.copy();
}

/// frameskip の取得
/// @return {Real}
/// @pure
function frameskip_get()
{
	return obj_system.frameskip;
}

/// frameskip の設定
/// @arg {Real} frameskip
function frameskip_set(_frameskip)
{
	obj_system.frameskip = _frameskip;
}

/// fader
/// @arg {Real} start
/// @arg {Real} target
/// @arg {Real} duration
/// @arg {Constant.Color} color
function fader_run(_start, _target, _duration, _color = c_black)
{
	obj_fader.color = _color;
	easing_run(obj_fader, "alpha", 0, 0, _start, _target - _start, _duration);
}

/// @arg {Real} gametime
/// @return {Real}
function gametime_to_sec(_gametime) {
	return floor(_gametime / 1_000) % 60;
}

/// @arg {Real} gametime
/// @return {Real}
function gametime_to_min(_gametime) {
	return floor(_gametime / (60_000)) % 60;
}

/// @arg {Real} gametime
/// @return {Real}
function gametime_to_hour(_gametime) {
	return floor(_gametime / (3600_000));
}

/// @arg {Real} gametime
/// @return {String}
function gametime_to_dtime(_gametime) {
	var _text = "";
	_text += $"{zero_padding(gametime_to_hour(_gametime), 2)}:";
	_text += $"{zero_padding(gametime_to_min(_gametime), 2)}:";
	_text += $"{zero_padding(gametime_to_sec(_gametime), 2)}";
	return _text;
}