alphafix(true);

draw_set_font(l10n_get_font("default"));
draw_set_colour(select_color);
draw_text_transformed_shadow(16, 8, $"CHAPTER {GAME_CHAPTER}", 2, 2, 0);

draw_text_transformed_shadow(80, 60, l10n_get_text("saveselect.selectfile"), 2, 2, 0);

for (var i = 0; i < 3; i++) {
	draw_savefile(i, 106, 106 + i * 90, "Natumi", "area.name.unknown", 99999999);
}

draw_menutext(3, 108, 380, l10n_get_text("saveselect.copy"));
draw_menutext(4, 280, 380, l10n_get_text("saveselect.erase"));
draw_menutext(5, 408, 380, l10n_get_text("saveselect.chselect"));
if (GAME_CHAPTER > 1) {
	draw_menutext(6, 108, 420, l10n_get_text("saveselect.chfile", [GAME_CHAPTER - 1]));
}
draw_set_font(l10n_get_font("default", lang_get_next()));
draw_menutext(7, 280, 420, l10n_get_text("saveselect.language"));
draw_set_font(l10n_get_font("default"));
draw_menutext(8, 408, 420, l10n_get_text("saveselect.endgame"));

alphafix(false);
