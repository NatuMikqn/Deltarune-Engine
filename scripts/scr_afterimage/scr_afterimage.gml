///@arg {real} x
///@arg {real} y
///@arg {real} depth
///@arg {Asset.GMSprite} sprite
///@arg {real} subimg
///@arg {real} xscale
///@arg {real} yscale
function afterimage_create(_x, _y, _depth, _sprite, _img, _xscale, _yscale){
	var _i = instance_create_depth(_x, _y, _depth, obj_afterimage);
	with(_i){
		sprite = _sprite;
		img = _img;
		scale = vector2(_xscale, _yscale);
	}
	return _i;
}