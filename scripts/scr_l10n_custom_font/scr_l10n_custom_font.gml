enum ASSETS_FONT{
	DIALOG
}

function l10n_assets_font(){
	
	lang_set(LANG.EN)
	
	l10n_set_font(ASSET_TYPE.FONT, ASSETS_FONT.DIALOG, fnt_8bit)
	
	lang_set(LANG.JA)
	
	l10n_set_font(ASSET_TYPE.FONT, ASSETS_FONT.DIALOG, fnt_jf14)
	
	lang_set(LANG.ZH)
	
	l10n_set_font(ASSET_TYPE.FONT, ASSETS_FONT.DIALOG, fnt_fzxs12)
	
}
