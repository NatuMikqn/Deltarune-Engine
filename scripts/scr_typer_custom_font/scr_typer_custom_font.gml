
function typewriter_custom_font()
{
	with(obj_typewriter_manager){
		
		new TCFontBuilder("default", "default")
			.target_lang(LANG.EN).set_sp_char(2).set_sp_line(0).set_sp_space(7).set_sp_asterisk(5)
			.target_lang(LANG.JA).set_sp_char(0).set_sp_line(0).set_sp_space(10).set_sp_asterisk(7)
			.target_lang(LANG.ZH).set_sp_char(0).set_sp_line(0).set_sp_space(10).set_sp_asterisk(7)
			.build()
		
		new TCFontBuilder("msgothic", "special")
			.set_global(true).set_sp_char(0).set_sp_line(0).set_sp_space(0)
			.build()
		
	}
}