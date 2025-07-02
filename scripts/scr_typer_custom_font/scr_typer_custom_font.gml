
function typewriter_custom_font()
{
	with(obj_typewriter_manager){
		
		new TCFBuilder("default", "default")
			.target_lang(LANG.EN).set_sp_char(0).set_sp_line(0).set_sp_space(3)
			.target_lang(LANG.JA).set_sp_char(0).set_sp_line(0).set_sp_space(5)
			.target_lang(LANG.ZH).set_sp_char(0).set_sp_line(0).set_sp_space(4)
			.register()
		
		new TCFBuilder("msgothic", font_add("font/msgothic001.ttf", 12, false, false, 0x20, 0x9fff))
			.set_global(true).set_sp_char(0).set_sp_line(0).set_sp_space(0)
			.register()
		
	}
}