///@ignore
function l10n_load_text()
{
	l10n_custom_text_loadjson();
	
	lang_set(LANG.EN);
	l10n_custom_text_en();
	
	lang_set(LANG.JA);
	l10n_custom_text_ja();
	
	lang_set(LANG.ZH);
	l10n_custom_text_zh();
}