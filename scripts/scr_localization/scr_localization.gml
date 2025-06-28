enum LANG{
	EN,
	JA,
	ZH
}

function localization_init(){
	global.localization_data = [];
	global.lang = LANG.EN;
	
	global.localization_assets = [];
	
	localization_en()
	localization_ja()
	localization_zh()
	
	localization_assets_font()
}

///@arg {real} lang
///@arg {string} name
///@arg {string} text
function localization_set(_lang, _name, _text){
	global.localization_data[_lang][_name] = _text;
}

///@arg {real} lang
///@arg {string} name
///@return {string}
function localization_get(_lang, _name){
	return global.localization_data[_lang][_name];
}

///@arg {real} lang
function lang_set(_lang){
	global.lang = _lang;
}

///@return {real}
function lang_get(){
	return global.lang;
}

///@arg {real} type
///@arg {real} id
///@arg {Asset} asset
function l10n_set_assets(_type, _id, _asset){
	var _lang = global.lang
	
	if !array_exists(global.localization_assets, _lang) global.localization_assets[_lang] = [];
	if !array_exists(global.localization_assets[_lang], _type) global.localization_assets[_lang][_type] = [];
	
	global.localization_assets[_lang][_type][_id] = _asset;
}

///@arg {real} type
///@arg {real} id
///@return {real}
function l10n_get_assets(_type, _id){
	var _lang = global.lang
	return global.localization_assets[_lang][_type][_id];
}

///@arg {string} name
///@arg {string} text
///@return {string}
function set_text(_name, _text){
	var _lang = global.lang;
	
	if !array_exists(global.localization_data, _lang) global.localization_data[_lang] = {}
	
	global.localization_data[_lang][$ _name] = _text;
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