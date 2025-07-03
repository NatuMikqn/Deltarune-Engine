///@ignore
function l10n_load_font()
{
	var _path = "font/fontdata.json";
	if (file_exists(_path)){
		var _list = json_load(_path),
			_data, _font, _fontpath;
		
		//./font/fontdata.jsonから自動で取得
		for (var i = 0; i < array_length(_list); i++) {
			_data = _list[i]
			lang_set(l10n_tag2lang(_data.lang));
			_fontpath = _data.font;
			
			if (string_char_at(_fontpath, 1) == "."){
				_fontpath = string_replace(_fontpath, ".", filename_dir(_path));
			}
			
			if (struct_exists(_data, "aa")){
				font_add_enable_aa(_data.aa);
			}else{
				font_add_enable_aa(false);
			}
			
			if (file_exists(_fontpath)){
				_font = font_add(_fontpath, _data.size, false, false, _data.range.first, _data.range.last);
				l10n_add_font(_data.parentname, _font);
			}else{
				throw _fontpath + "doesn't exists"
			}
		}
	}
	
	lang_set(LANG.EN);
	l10n_custom_font_en();
	
	lang_set(LANG.JA);
	l10n_custom_font_ja();
	
	lang_set(LANG.ZH);
	l10n_custom_font_zh();
	
}
