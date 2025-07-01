///IDEから実行されているかどうかを確認します
///@return {bool}
///@pure
function is_test(){
	return (GM_build_type == "run");
}

///@arg {real} width
///@arg {real} height
function screen_set_size(_w, _h){
	
	obj_camera.scale.x = 1
	obj_camera.scale.y = 1
	window_set_size(_w, _h)
}