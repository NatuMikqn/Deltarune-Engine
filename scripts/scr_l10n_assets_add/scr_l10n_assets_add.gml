///langjsonの登録
///@arg {real} lang
///@arg {string} fname
function l10n_loadjson(_lang, _fname)
{
	var _path = $"langs/{_fname}";
	if (file_exists(_path)){
		var _file = file_text_open_read(_path)
		var _json = "";
		while (!file_text_eof(_file)){
			_json += file_text_read_string(_file);
			file_text_readln(_file);
		}
		
		global.localization_data.text[_lang] = json_parse(_json);
		file_text_close(_file);
	}else{
		show_debug_message($"Language JSON file not found : {_path}");
	}
}

///langの登録
///@arg {String} name
///@arg {String} text
function l10n_add_text(_name, _text)
{
	l10n_add("text", _name, _text)
}

///fontの登録
///@arg {String} name
///@arg {Asset.GMFont} font
function l10n_add_font(_name, _font)
{
	l10n_add("font", _name, _font)
}

///spriteの登録
///@arg {String} name
///@arg {Asset.GMSprite} sprite
function l10n_add_sprite(_name, _sprite)
{
	l10n_add("sprite", _name, _sprite)
}

///l10n保存
///@arg {String} target
///@arg {String} name
///@arg {Any} value
///@ignore
function l10n_add(_target, _name, _value)
{
	var _lang = global.lang;
	
	if !array_exists(global.localization_data[$_target], _lang) global.localization_data[$_target][_lang] = {};
	
	global.localization_data[$_target][_lang][$ _name] = _value;
}