surface_set_target(srf_battle)
alphafix(true)
draw_sprite_ext(spr_screen_debug, dbg_screen_img, 0, 0, 0.5, 0.5, 0, c_white, dbg_screen_alpha)
alphafix(false)
surface_reset_target()

alphafix(true)
draw_surface(srf_battle, clamp(obj_camera.x, 0, room_width), clamp(obj_camera.y, 0, room_height))
alphafix(false)