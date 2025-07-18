///指定したsurfaceをぼかします
///返り値はありません
///また、x位置とy位置は、それぞれ指定した半径分ずれます
///@arg {Id.Surface} surface ぼかす対象のsurface
///@arg {Real} xradius 横ぼかしの半径
///@arg {Real} yradius 縦ぼかしの半径
///@arg {Bool} sizefixed サイズを固定にするか
///@arg {Real} bloom スキップ幅
///@arg {Bool} vertical 最初のぼかしを縦方向にする
function surface_set_blur(_surface, _rx, _ry, _sizefixed = false, _bloom = 1, _blurvertical = false){
	var _tex, _texel, _return
	
	static surface_ping = -1;
	static surface_pong = -1;
	
	static blur_uniform = {
			texel : shader_get_uniform(shd_blur, "textureTexel"),
			radius : shader_get_uniform(shd_blur, "radius"),
			bloom : shader_get_uniform(shd_blur, "bloom"),
			vertical : shader_get_uniform(shd_blur, "vertical")
		}
	
	var _source_size = new Vector2(
			surface_get_width(_surface) + (_rx * 2) * !_sizefixed,
			surface_get_height(_surface) + (_ry * 2) * !_sizefixed
		);
	
	if (_source_size.x < 1 || _source_size.y < 1){
		throw "縦横それぞれのサイズは1以上である必要があります"
	}
	
	if !surface_exists(surface_ping){
		surface_ping = surface_create(_source_size.x, _source_size.y)
	}
	if !surface_exists(surface_pong){
		surface_pong = surface_create(_source_size.x, _source_size.y)
	}
	if (surface_get_width(surface_ping) != _source_size.x || surface_get_height(surface_ping) != _source_size.y){
		surface_resize(surface_ping, _source_size.x, _source_size.y)
		surface_resize(surface_pong, _source_size.x, _source_size.y)
	}
	
	_tex = surface_get_texture(_surface);
	_texel = [texture_get_texel_width(_tex), texture_get_texel_height(_tex)];
	
	//pingにsurfaceを書き込む
	surface_set_target(surface_ping);
	draw_clear_alpha(c_black, 0);
	draw_surface(_surface, _rx * !_sizefixed, _ry * !_sizefixed)
	surface_reset_target()
	
	//shader設定1
	shader_set(shd_blur);
	shader_set_uniform_f(blur_uniform.texel, _texel[0], _texel[1]);
	shader_set_uniform_f(blur_uniform.bloom, _bloom);
	shader_set_uniform_f(blur_uniform.radius, _rx);
	shader_set_uniform_i(blur_uniform.vertical, _blurvertical);
	//水平ブラー
	surface_set_target(surface_pong);
	draw_clear_alpha(c_black, 0);
	draw_surface(surface_ping, 0, 0);
	surface_reset_target();
	
	//元surfaceのサイズ調整
	surface_resize(_surface, _source_size.x, _source_size.y)
	
	//shader設定2
	shader_set_uniform_f(blur_uniform.radius, _ry);
	shader_set_uniform_i(blur_uniform.vertical, !_blurvertical);
	//垂直ブラー
	surface_set_target(_surface);
	draw_clear_alpha(c_black, 0);
	draw_surface(surface_pong, 0, 0);
	surface_reset_target();
	shader_reset();
}

///surface_set_blurのgetバージョンです
///元surfaceには変更が加えられません
///@arg {Id.Surface} surface ぼかす対象のsurface
///@arg {Real} xradius 横ぼかしの半径
///@arg {Real} yradius 縦ぼかしの半径
///@arg {Bool} sizefixed サイズを固定にするか
///@arg {Real} bloom スキップ幅
///@arg {Bool} vertical 最初のぼかしを縦方向にする
function surface_get_blur(_surface, _rx, _ry, _sizefixed = false, _bloom = 1, _blurvertical = false){
	var _srf = surface_create(surface_get_width(_surface), surface_get_height(_surface))
	surface_copy(_srf, 0, 0, _surface)
	surface_set_blur(_srf, _rx, _ry, _sizefixed, _bloom, _blurvertical)
	return _srf;
}