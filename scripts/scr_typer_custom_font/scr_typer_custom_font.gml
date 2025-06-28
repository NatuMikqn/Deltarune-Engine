
function typewriter_custom_font()
{
	with(obj_typewriter_manager){
		
		new TyperCustomFont("normal")
			
			.add_font(new TyperFontData(LANG.EN).add_font(fnt_8bit))
			
			.add_font(new TyperFontData(LANG.JA).add_font(fnt_jf14))
			
			.add_font(new TyperFontData(LANG.ZH).add_font(fnt_fzxs12))
			
			.register()
			
		new TyperCustomFont("special")
			
			.add_font(
				new TyperFontData(LANG.JA)
					.add_font_ttf("font/msgothic001.ttf", 12, 0x20, 0x7f)
					.add_font_ttf("font/msgothic001.ttf", 12, 0x3000, 0x9fff)
				)
			
			.register()
		
	}
}