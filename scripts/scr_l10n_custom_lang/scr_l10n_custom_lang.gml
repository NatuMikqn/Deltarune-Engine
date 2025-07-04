enum LANG
{
	EN,
	JA,
	ZH
}

///@ignore
function l10n_custom_lang()
{
	//ここで言語にタグをつけることができます
	//一つの言語に複数のタグをつけることが可能です
	l10n_set_langtag(LANG.EN, "global");
	l10n_set_langtag(LANG.EN, "en");
	l10n_set_langtag(LANG.JA, "ja");
	l10n_set_langtag(LANG.ZH, "zh");
}