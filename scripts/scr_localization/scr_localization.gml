enum LANG{
	EN,
	JA,
	ZH
}
enum L10N_GROUP{
	TITLE,
	DIALOG,
	MENU,
	BATTLE
}

function localization_init(){
	global.localization_data = [];
	global.lang = LANG.EN;
	global.localization_target_group = -1;
	
	global.localization_assets = [];
	
	localization_en()
	localization_ja()
	localization_zh()
	
	localization_assets_font()
}

///@arg {real} lang
///@arg {real} group
///@arg {string} name
///@arg {string} text
function localization_set(_lang, _group, _name, _text){
	global.localization_data[_group][_lang][_name] = _text;
}

///@arg {real} lang
///@arg {real} group
///@arg {string} name
///@return {string}
function localization_get(_lang, _group, _name){
	return global.localization_data[_group][_lang][_name];
}

///@arg {real} group
function localization_set_group(_group){
	global.localization_target_group = _group;
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
	var _group = global.localization_target_group,
		_lang = global.lang
	
	if !array_exists(global.localization_data, _group) global.localization_data[_group] = []
	if !array_exists(global.localization_data[_group], _lang) global.localization_data[_group][_lang] = {}
	
	global.localization_data[_group][_lang][$ _name] = _text;
}

///@arg {string} name
///@return {string}
function get_text(_name){
	var _group = global.localization_target_group,
		_lang = global.lang
	
	if !array_exists(global.localization_data, _group)			return _name;
	if !array_exists(global.localization_data[_group], _lang)	return _name;
	
	var _data = global.localization_data[_group][_lang]
	
	if struct_exists(_data, _name){
		return _data[$ _name];
	}return _name;
}