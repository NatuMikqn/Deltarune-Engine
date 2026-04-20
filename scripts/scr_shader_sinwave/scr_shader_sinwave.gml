/// 画面揺れのセットアップ
/// @arg {Real} time 経過時間
/// @arg {Real} width 横幅
/// @arg {Real} height 高さ
/// @arg {Real} strength ステップ幅
/// @arg {Real} texel_w 画像横幅
/// @arg {Real} texel_h 画像縦幅
/// @arg {Bool} vertical 縦揺れ
function shader_sinwave_setup(_time, _width, _height, _strength, _texel_w, _texel_h, _vertical = false) {
	
	static screen_sinwave_uniforms = {
		time : shader_get_uniform(shd_sinwave, "time"),
		width : shader_get_uniform(shd_sinwave, "width"),
		height : shader_get_uniform(shd_sinwave, "height"),
		strength : shader_get_uniform(shd_sinwave, "strength"),
		vertical : shader_get_uniform(shd_sinwave, "vertical"),
		texel : shader_get_uniform(shd_sinwave, "texelSize"),
	}
	
	if (shader_current() == -1) {
		shader_set(shd_sinwave);
	}
	
	if (shader_current() == shd_sinwave) {
		shader_set_uniform_f(screen_sinwave_uniforms.time, _time);
		shader_set_uniform_f(screen_sinwave_uniforms.width, _width);
		// ゼロ除算回避のためmaxを使用
		shader_set_uniform_f(screen_sinwave_uniforms.height, max(_height, 1));
		shader_set_uniform_f(screen_sinwave_uniforms.strength, _strength);
		shader_set_uniform_f(screen_sinwave_uniforms.vertical, _vertical);
		shader_set_uniform_f(screen_sinwave_uniforms.texel, _texel_w, _texel_h);
	}
}

/// セーブセレクト用sinwave
/// @arg {Real} time 経過時間
/// @arg {Real} ystart 揺れ開始位置
/// @arg {Real} period 揺れ周期
/// @arg {Real} power 揺れ増加
/// @arg {Real} texel_w 画像横幅
/// @arg {Real} texel_h 画像縦幅
/// @ignore
function shader_sinwave_ss_setup(_time, _ystart, _period, _power, _texel_w, _texel_h) {
	
	static screen_sinwave_uniforms = {
		time : shader_get_uniform(shd_sinwave_saveselect, "time"),
		ystart : shader_get_uniform(shd_sinwave_saveselect, "ystart"),
		period : shader_get_uniform(shd_sinwave_saveselect, "period"),
		power : shader_get_uniform(shd_sinwave_saveselect, "power"),
		texel : shader_get_uniform(shd_sinwave_saveselect, "texelSize"),
	}
	
	if (shader_current() == -1) {
		shader_set(shd_sinwave_saveselect);
	}
	
	if (shader_current() == shd_sinwave_saveselect) {
		shader_set_uniform_f(screen_sinwave_uniforms.time, _time);
		shader_set_uniform_f(screen_sinwave_uniforms.ystart, _ystart);
		// ゼロ除算回避のためmaxを使用
		shader_set_uniform_f(screen_sinwave_uniforms.period, _period);
		shader_set_uniform_f(screen_sinwave_uniforms.power, _power);
		shader_set_uniform_f(screen_sinwave_uniforms.texel, _texel_w, _texel_h);
	}
}