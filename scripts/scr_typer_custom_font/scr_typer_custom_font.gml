
function typewriter_custom_font()
{
	with(obj_typewriter_manager){
		
		new TCFBuilder("default", "default")
			.set_spacing_char(LANG.EN, 10)
			.set_spacing_char(LANG.JA, 10)
			.set_spacing_char(LANG.ZH, 10)
			.register()
		
		/*new TyperCustomFont("special")
			
			.add_font(
				new TyperFontData(LANG.JA)
					.add_font_ttf("font/msgothic001.ttf", 12, 0x20, 0x7f)
					.add_font_ttf("font/msgothic001.ttf", 12, 0x3000, 0x9fff)
				)
			
			.register()
		*/
	}
}