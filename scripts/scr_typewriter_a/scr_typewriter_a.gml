
///指定したタグが付いているtypewriterを削除します
///@arg {String} tag
function typewriter_delete(_tag) {
	with (obj_typewriter_manager){
		for (var i = 0; i < array_length(list); i++) {
			if (list[i].tag_equals(_tag)){
				array_delete(list, i, 1)
				i--
			}
		}
	}
}

///指定したタグが付いているtypewriterが存在するかどうか
///@arg {String} tag
///@return {Bool}
function typewriter_exists(_tag) {
	with (obj_typewriter_manager){
		for (var i = 0; i < array_length(list); i++) {
			if (list[i].tag_equals(_tag)){
				return true;
			}
		}
	}
	return false;
}

///typewriter用のフォントを取得します
///@arg {String} tag
///@return {Struct.TCFData}
function typewriter_font_get(_tag) {
	with (obj_typewriter_manager){
		for (var i = 0; i < array_length(font_list); i++) {
			if (font_list[i].tag_equals(_tag)){
				return font_list[i];
			}
		}
		throw "Tag \"" + string(_tag) + "\"doesn't exists"
	}
	throw "obj_typewriter_manager doesn't exists"
}