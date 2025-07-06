///IDEから実行されているかどうかを確認します
///@return {bool}
///@pure
function is_test()
{
	return (GM_build_type == "run");
}

///@arg {real} width
///@arg {real} height
function screen_set_size(_w, _h)
{
	obj_camera.scale.x = 1
	obj_camera.scale.y = 1
	window_set_size(_w, _h)
}

///開始からの経過フレームを返します
///@return {Real}
function get_worldtimer()
{
	return obj_system.timer;
}

///Builderの変数群から基盤のみ存在する変数をDataへ移行する
function send_builder_to_data(_builder)
{
	var _lists = variable_struct_get_names(self);
	
	array_foreach(_lists, method(_builder, function(_e){
		other[$_e] = self[$_e];
	}))
}