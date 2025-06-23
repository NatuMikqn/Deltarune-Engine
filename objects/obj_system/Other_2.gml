
global_init()

instance_create_depth(0, 0, 0, obj_camera)
instance_create_depth(0, 0, 0, obj_typewriter_manager)

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


room_goto(rm_area_test)
