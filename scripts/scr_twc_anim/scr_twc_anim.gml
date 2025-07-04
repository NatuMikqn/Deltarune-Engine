
///タイプライター用の作成アニメーションを追加します
///@arg {String} name animationName
///@arg {Function} func method
function typewriter_add_animcreate(_name, _func)
{
	obj_typewriter_manager.anim_list.create[$ _name] = [_func, undefined];
}

///タイプライター用のステップアニメーションを追加します
///@arg {String} name animationName
///@arg {Function} func method
///@arg {Function} exitfunc end animation
function typewriter_add_animstep(_name, _func, _ef = undefined)
{
	obj_typewriter_manager.anim_list.step[$ _name] = [_func, _ef];
}
