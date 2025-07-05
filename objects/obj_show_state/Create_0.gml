alpha = 1;
textsrf = -1;
text = $"VERSION : {GM_version}";
font = l10n_get_font("default", LANG.EN);

easing_run(id, "alpha", EASING_TWEEN.LINEAR, EASING_EASE.IN, 1, -1, 60, 120);

alarm[0] = 180;