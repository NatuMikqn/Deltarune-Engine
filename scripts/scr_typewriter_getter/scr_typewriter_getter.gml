
///指定したタグが付いているtypewriterを削除します
///@arg {String} tag
///@deprecated
function typewriter_delete(_tag) {
	with (obj_typewriter_object){
		if (data.tag_equals(_tag)){
			instance_destroy();
		}
	}
}

///指定したタグが付いているtypewriterが存在するかどうか
///@arg {String} tag
///@return {Bool}
///@deprecated
function typewriter_exists(_tag) {
	with (obj_typewriter_object){
		if (data.tag_equals(_tag)){
			return true;
		}
	}
	return false;
}

///typewriter用のフォントを取得します
///@arg {String} tag
///@return {Struct.TCFontData}
function typewriter_font_get(_tag) {
	with (obj_typewriter_manager){
		if (struct_exists(font_list, _tag)){
			return font_list[$ _tag];
		}else throw "Tag \"" + string(_tag) + "\" doesn't exists"
	}
	throw "obj_typewriter_manager doesn't exists"
}

///アニメーション関数を取得します
///@arg {Real} type TCANIM.?
///@arg {String} name
///@return {Function}
function typewriter_anim_get(_type, _name) {
	with (obj_typewriter_manager){
		var _typename = ""
		switch (_type) {
			case TCANIM.CREATE: _typename = "create"; break;
			case TCANIM.STEP: _typename = "step"; break;
			
			default: throw "Unknown Type : " + string(_type);
		}
		
		if (struct_exists(anim_list[$_typename], _name)){
			return obj_typewriter_manager.anim_list[$_typename][$ _name];
		}else throw "Name \"" + string(_name) + "\" doesn't exists"
	}
	throw "obj_typewriter_manager doesn't exists"
}