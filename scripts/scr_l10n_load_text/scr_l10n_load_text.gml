///@ignore
function l10n_load_text()
{
	var _path = "text/textdata.json";
	if (file_exists(_path)){
		
		var _list = json_load(_path),
			_data, _jsonpath;
		
		//./font/fontdata.jsonから自動で取得
		for (var i = 0; i < array_length(_list); i++) {
			_data = _list[i]
			
			_jsonpath = _data.path;
			if (string_char_at(_jsonpath, 1) == "."){
				_jsonpath = string_replace(_jsonpath, ".", filename_dir(_path));
			}
			
			if (file_exists(_jsonpath)){
				l10n_loadjson(l10n_tag2lang(_data.lang), _jsonpath);
			}else{
				throw _jsonpath + " doesn't exists"
			}
		}
	}
	
	lang_set(LANG.EN);
	l10n_custom_text_en();
	
	lang_set(LANG.JA);
	l10n_custom_text_ja();
	
	lang_set(LANG.ZH);
	l10n_custom_text_zh();
}