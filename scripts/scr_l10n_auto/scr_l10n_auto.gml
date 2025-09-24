//@url https://en.wikipedia.org/wiki/ISO_639
function l10n_custom_autolang(){
	var _lang = os_get_language();
	switch (_lang){
		case "en":
			lang_set(LANG.EN);
			break;
		case "ja":
			lang_set(LANG.JA);
			break;
		case "zh":
			lang_set(LANG.ZH);
			break;
		default:
			lang_set(LANG.EN);
	}
}