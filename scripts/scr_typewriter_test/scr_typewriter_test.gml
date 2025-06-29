
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