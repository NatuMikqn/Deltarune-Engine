instance_create_depth(0, 0, 0, obj_camera)
instance_create_depth(0, 0, 0, obj_typewriter_manager)

easing_init()

localization_init()
lang_set(LANG.EN)

team_init()

overworld_init()

encounter_init()

input_init()
input_config(INPUT.UP, vk_up)
input_config(INPUT.DOWN, vk_down)
input_config(INPUT.LEFT, vk_left)
input_config(INPUT.RIGHT, vk_right)
input_config(INPUT.CONFIRM, [ord("Z"), vk_enter])
input_config(INPUT.CANCEL, [ord("X"), vk_shift])
input_config(INPUT.MENU, [ord("C"), vk_control])
input_config(INPUT.ANY, vk_anykey)
input_endsetup()

team_custom()
encounter_group()

global.hpfont = font_add_sprite_ext(spr_font_small, "0123456789-+", false, 1)

room_goto(rm_area_test)
