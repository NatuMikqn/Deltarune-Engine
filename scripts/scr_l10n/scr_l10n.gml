
enum LANG
{
	EN,
	JA,
	ZH
}

///@ignore
function localization_init()
{
	global.lang = LANG.EN;
	global.localization_data = {
		text : [],
		font : [],
		sprite : [],
	}
	
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