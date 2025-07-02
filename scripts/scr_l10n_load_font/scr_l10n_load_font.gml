///@ignore
function l10n_load_font()
{
	var _path = "font/fontdata.json";
	if (file_exists(_path)){
		var _list = json_load(_path),
			_data;
		
		for (var i = 0; i < array_length(_list); i++) {
			_data = _list[i]
			lang_set(_data.lang);
			l10n_add_font("default", font_add(_data.font, _data.size, false, false, _data.range.first, _data.range.last));
		}
	}
	
	lang_set(LANG.EN);
	l10n_custom_font_en();
	
	lang_set(LANG.JA);
	l10n_custom_font_ja();
	
	lang_set(LANG.ZH);
	l10n_custom_font_zh();
	
}
