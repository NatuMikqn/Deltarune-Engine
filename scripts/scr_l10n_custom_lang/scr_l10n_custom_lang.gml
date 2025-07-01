function l10n_custom_lang(){
	
	l10n_loadjson(LANG.EN, "en.json")
	l10n_loadjson(LANG.JA, "ja.json")
	l10n_loadjson(LANG.ZH, "zh.json")
	
	// You can also add text here after loading the JSON
	/*
	lang_set(LANG.EN);
	
	l10n_add_langtext("l10n.message.0", "Hello World");
	l10n_add_langtext("l10n.message.1", "I like the orange color");
	*/
}