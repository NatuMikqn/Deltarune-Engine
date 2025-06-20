global.screen_size = new Vector2(640, 480)

///@return {bool}
function is_paused(){
	return global.pause;
}

///@arg {real} width
///@arg {real} height
function screen_set_size(_w, _h){
	
	obj_camera.scale.x = 1
	obj_camera.scale.y = 1
	window_set_size(_w, _h)
}