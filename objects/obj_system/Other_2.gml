window_enable_borderless_fullscreen(true);
global_init();

instance_create_depth(0, 0, 0, obj_camera)
instance_create_depth(0, 0, 0, obj_typewriter_manager)
instance_create_depth(0, 0, 0, obj_fps_viewer)

easing_init()

localization_init()
lang_set(LANG.EN)

team_init()

overworld_init()

encounter_init()

instance_create_depth(0, 0, 0, obj_input_manager)
input_custom()

team_custom()
encounter_group()

global.hpfont = font_add_sprite_ext(spr_font_small, "0123456789-+", false, 1)
global.dmgfont = font_add_sprite_ext(spr_font_big, "0123456789-+%/", true, 0)


room_goto(rm_area_test)
