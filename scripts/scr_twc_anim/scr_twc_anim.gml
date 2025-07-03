
///タイプライター用のフォントを追加します
///@arg {Real} type TCANIM.?
///@arg {String} name animationName
///@arg {Function} func method
///@arg {Real} sleeptime 1 -> 30fps
function typewriter_add_anim(_type, _name, _func, _sleeptime = 0)
{
	var _animtype = "";
	switch (_type) {
		case TCANIM.CREATE:
			_animtype = "create";
			break;
		case TCANIM.STEP:
			_animtype = "step";
			break;
		
		default:
			throw "unknown animtype"
	}
	obj_typewriter_manager.anim_list[$ _animtype][$ _name] = [_func, _sleeptime];
}
