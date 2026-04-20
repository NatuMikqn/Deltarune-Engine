time = 0;
enable_half_fps = true;

frameskip_prevtemp = 0;

surface = -1;

step = 0;
startwave = irandom(359);

// fadein
// fadeout
factor_alpha = 0;
// logofadeout
factor_logoalpha = 0;
// glow bloom
// sinwave - width
factor_effect = 0;

easing_run(id, "factor_alpha", 0, 0, 0, 1, 160);
easing_run(id, "factor_effect", 2, 0, 0, 1, 160);


sound_intro = audio_play_sound(snd_intro, 0, 0);

can_skip = true;