surface_set_target(srf_battle)
alphafix(true)
draw_sprite_ext(spr_screen_debug, dbg_screen_img, 0, 0, 0.5, 0.5, 0, c_white, dbg_screen_alpha)
surface_reset_target()

draw_surface(srf_battle, obj_camera.viewpos.x, obj_camera.viewpos.y)
alphafix(false)