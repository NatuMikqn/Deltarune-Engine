///@ignore
function l10n_load_text()
{
	l10n_loadjson(LANG.EN, "en.json");
	l10n_loadjson(LANG.JA, "ja.json");
	l10n_loadjson(LANG.ZH, "zh.json");
	
	lang_set(LANG.EN);
	l10n_custom_text_en();
	
	lang_set(LANG.JA);
	l10n_custom_text_ja();
	
	lang_set(LANG.ZH);
	l10n_custom_text_zh();
}