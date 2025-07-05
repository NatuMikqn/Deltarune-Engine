///カメラのX位置を返します
///@return {Real}
function camera_get_viewpos_x()
{
	if (instance_exists(obj_camera)){
		return obj_camera.viewpos.x;
	}
	
}
///カメラのY位置を返します
///@return {Real}
function camera_get_viewpos_y()
{
	if (instance_exists(obj_camera)){
		return obj_camera.viewpos.y;
	}
	test_edit
}