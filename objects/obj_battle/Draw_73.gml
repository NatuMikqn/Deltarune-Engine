surface_set_target(srf_battle)
alphafix(true)
draw_sprite_ext(spr_screen_debug, dbg_screen_img, 0, 0, 0.5, 0.5, 0, c_white, dbg_screen_alpha)
surface_reset_target()

draw_surface(srf_battle, camera_get_viewpos_x(), camera_get_viewpos_y())
alphafix(false)