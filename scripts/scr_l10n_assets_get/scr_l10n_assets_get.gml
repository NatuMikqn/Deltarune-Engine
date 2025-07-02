///ローカライズされた文章を取得します
///@arg {String} name localizationで設定した名前を指定
///@arg {Array<String>} template %を置き換えます
///@arg {Real} lang 言語指定
///@return {string}
function get_text(_name, _template = [], _lang = lang_get())
{
	if (!array_exists(global.localization_data.text, _lang)) return _name;
	
	var _data = global.localization_data.text[_lang];
	
	if struct_exists(_data, _name){
		var _text = _data[$ _name];
		var _pos = string_pos_ext("%", _text, 1);
		var _string = "";
		while (_pos != 0) {
			if (string_char_at(_text, _pos + 1) != "%"){
				_text = string_delete(_text, _pos, 1);
				_string = array_shift(_template);
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

///ローカライズされたフォントを取得します
///@arg {String|Asset.GMFont} name localizationで設定した名前を指定 Assetの場合そのまま返します
///@return {Asset.GMFont}
function get_font(_name, _lang = lang_get())
{
	if (asset_get_type(_name) == asset_font) return _name;
	
	if (!array_exists(global.localization_data.font, _lang)) throw "Unknown language : " + string(_lang);
	if (!struct_exists(global.localization_data.font[_lang], _name)) throw "Font not found";
	
	return global.localization_data.font[_lang][$_name];
}

///ローカライズされたスプライトを取得します
///@arg {String|Asset.GMSprite} name localizationで設定した名前を指定 Assetの場合そのまま返します
///@return {Asset.GMSprite}
function get_sprite(_name, _lang = lang_get())
{
	if (asset_get_type(_name) == asset_sprite) return _name;
	
	if (!array_exists(global.localization_data.sprite, _lang)) throw "Unknown language : " + string(_lang);
	if (!struct_exists(global.localization_data.sprite[_lang], _name)) return spr_missing;
	
	return global.localization_data.sprite[_lang][$_name];
}