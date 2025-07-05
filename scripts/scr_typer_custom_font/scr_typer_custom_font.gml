
function typewriter_custom_font()
{
	with(obj_typewriter_manager){
		
		new TCFontBuilder("default", "default")
			.target_lang(LANG.EN).set_w_char(8).set_sp_line(-4).set_w_space(8).set_w_asterisk(8)
			//.target_lang(LANG.EN).set_sp_char(2).set_sp_line(-3).set_w_space(8).set_w_asterisk(6)
			.target_lang(LANG.JA).set_sp_char(0).set_sp_line(0).set_w_space(10).set_w_asterisk(NaN)
			.target_lang(LANG.ZH).set_sp_char(0).set_sp_line(0).set_w_space(infinity).set_w_asterisk(NaN)
			.build()
		
		new TCFontBuilder("msgothic", "special")
			.set_global(true).set_sp_char(0).set_sp_line(0).set_w_space(0)
			.build()
		
	}
}