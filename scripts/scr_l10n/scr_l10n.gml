
enum LANG{
	EN,
	JA,
	ZH
}

function localization_init(){
	global.lang = LANG.EN;
	global.localization_data = {
		text : [],
		font : [],
		sprite : [],
	}
	
	l10n_custom_lang();
}

///langjsonの登録
///@arg {real} lang
///@arg {string} fname
function l10n_loadjson(_lang, _fname){
	if (file_exists($"langs/{_fname}")){
		var _file = file_text_open_read($"langs/{_fname}")
		var _json = "";
		while (!file_text_eof(_file)){
			_json += file_text_read_string(_file);
			file_text_readln(_file);
		}
		
		global.localization_data.text[_lang] = json_parse(_json);
		file_text_close(_file);
	}else{
		throw "言語JSONが存在しません"
	}
}

///langの登録
///@arg {String} name
///@arg {String} text
///@return {String}
function l10n_add_langtext(_name, _text){
	var _lang = global.lang;
	
	if !array_exists(global.localization_data, _lang) global.localization_data[_lang] = {};
	
	global.localization_data[_lang][$ _name] = _text;
}

///fontの登録
///@arg {String} name
///@arg {Asset.GMFont} font
///@return {String}
function l10n_add_langfont(_name, _font){
	var _lang = global.lang;
	
	if !array_exists(global.localization_font, _lang) global.localization_font[_lang] = {};
	
	global.localization_font[_lang][$ _name] = _font;
}

///spriteの登録
///@arg {String} name
///@arg {Asset.GMSprite} sprite
///@return {String}
function l10n_add_langsprite(_name, _sprite){
	var _lang = global.lang;
	
	if !array_exists(global.localization_sprite, _lang) global.localization_sprite[_lang] = {};
	
	global.localization_sprite[_lang][$ _name] = _sprite;
}

///ローカライズされた文章を取得します
///@arg {String} name localizationで設定した名前を指定
///@arg {Array<String>} template %を置き換えます 
///@return {string}
function get_text(_name, _template = []){
	var _lang = global.lang;
	if !array_exists(global.localization_data, _lang)	return _name;
	
	var _data = global.localization_data[_lang]
	
	if struct_exists(_data, _name){
		var _text = _data[$ _name];
		var _pos = string_pos_ext("%", _text, 1);
		var _string = "";
		while (_pos != 0) {
			if (string_char_at(_text, _pos + 1) != "%"){
				_text = string_delete(_text, _pos, 1)
				_string = array_shift(_template)
				_text = string_insert(_string, _text, _pos);
				_pos += string_length(_string);
				if (array_empty(_template)){
					break;
				}
			}else{
				_text = string_delete(_text, _pos, 1);
				_pos++
			}
			_pos = string_pos_ext("%", _text, _pos);
		}
		return _text;
	}return _name;
}