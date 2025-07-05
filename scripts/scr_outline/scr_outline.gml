///指定したsurfaceにoutlineを実装します
///@arg {Id.Surface} surface 対象のsurface
///@arg {Real} xradius 横の半径
///@arg {Real} yradius 縦の半径
///@arg {Real|Constant.Color} rgb 色
///@arg {Real} alpha 透明度
///@arg {Real} sampleCount (max(xradius, yradius) * 8) アウトラインがギザギザする場合に大きくしてみてください
///@arg {Bool} sizefixed サイズを固定にするか
function surface_set_outline(_surface, _rx, _ry, rgb = c_black, alpha = 1, sc = max(_rx, _ry) * 8, _sizefixed = false){
	
	var _tex, _texel, _return, _rgba
	
	static surface_ping = -1;
	
	static blur_uniform = {
			texel : shader_get_uniform(shd_outline, "textureTexel"),
			radius : shader_get_uniform(shd_outline, "radius"),
			color : shader_get_uniform(shd_outline, "color"),
			sc : shader_get_uniform(shd_outline, "sampleCount"),
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
	if (surface_get_width(surface_ping) != _source_size.x || surface_get_height(surface_ping) != _source_size.y){
		surface_resize(surface_ping, _source_size.x, _source_size.y)
	}
	
	_tex = surface_get_texture(surface_ping);
	_texel = [texture_get_texel_width(_tex), texture_get_texel_height(_tex)];
	
	//サイズ拡張されたpingに元のsurfaceを書き込む
	surface_set_target(surface_ping);
	draw_clear_alpha(c_black, 0);
	draw_surface(_surface, _rx * !_sizefixed, _ry * !_sizefixed)
	surface_reset_target()
	
	//shader設定1
	_rgba = [
		(rgb & 0xff) / 255,
		((rgb >> 8) & 0xff) / 255,
		((rgb >> 16) & 0xff) / 255,
		alpha
	]
	shader_set(shd_outline);
	shader_set_uniform_f(blur_uniform.texel, _texel[0], _texel[1]);
	shader_set_uniform_f(blur_uniform.radius, _rx, _ry);
	shader_set_uniform_f_array(blur_uniform.color, _rgba);
	shader_set_uniform_f(blur_uniform.sc, sc);
	
	//元surfaceのサイズ調整
	surface_resize(_surface, _source_size.x, _source_size.y)
	
	//Outline
	surface_set_target(_surface);
	draw_clear_alpha(c_black, 0);
	draw_surface(surface_ping, 0, 0);
	surface_reset_target();
	shader_reset();
}

///surface_set_outlineのgetバージョンです
///元surfaceには変更が加えられません
///@arg {Id.Surface} surface 対象のsurface
///@arg {Real} xradius 横の半径
///@arg {Real} yradius 縦の半径
///@arg {Real|Constant.Color} rgb 色
///@arg {Real} alpha 透明度
///@arg {Real} sampleCount アウトラインがギザギザする場合に大きくしてみてください
///@arg {Bool} sizefixed サイズを固定にするか
function surface_get_outline(_surface, _rx, _ry, rgb = c_white, alpha = 1, sc = max(_rx, _ry) * 8, _sizefixed = false){
	var _srf = surface_create(surface_get_width(_surface), surface_get_height(_surface))
	surface_copy(_srf, 0, 0, _surface)
	surface_set_outline(_surface, _rx, _ry, rgb, alpha, sc, _sizefixed)
	return _srf;
}