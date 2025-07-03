
///@ignore
function localization_init()
{
	global.lang = LANG.EN;
	global.langtag = {};
	global.localization_data = {
		text : [],
		font : [],
		sprite : [],
	}
	font_add_enable_aa(false);
	
	l10n_custom_lang();
	
	l10n_load_text();
	l10n_load_font();
	l10n_load_sprite();
}

///言語変更
///@arg {Real} lang LANG.?
function lang_set(_lang)
{
	global.lang = _lang;
}

///言語取得
function lang_get()
{
	return global.lang;
}

///LANG列挙型に文字列タグを付けます
///タグは複数付けれます
///@arg {Real} lang
///@arg {String} tag
function l10n_set_langtag(_lang, _tag)
{
	global.langtag[$ _tag] = _lang;
}

///文字列タグからLANG_IDを返します
///@arg {String} tag
///@return {Real}
function l10n_tag2lang(_tag)
{
	return global.langtag[$ _tag];
}