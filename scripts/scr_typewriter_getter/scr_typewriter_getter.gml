
///指定したタグが付いているtypewriterを取得します
///@arg {String} tag
///@return {Id.Instance}
function typewriter_get(_tag)
{
	with (obj_typewriter_object){
		if (data.tag_equals(_tag)){
			return id;
		}
	}
}
///指定したタグが付いているtypewriterを削除します
///@arg {String} tag
function typewriter_delete(_tag)
{
	with (obj_typewriter_object){
		if (data.tag_equals(_tag)){
			instance_destroy();
		}
	}
}
///指定したタグが付いているtypewriterが存在するかどうか
///@arg {String} tag
///@return {Bool}
function typewriter_exists(_tag)
{
	with (obj_typewriter_object){
		if (data.tag_equals(_tag)){
			return true;
		}
	}
	return false;
}

///TypewriterのCreateID取得
///@return {Real}
function typewriter_get_cid()
{
	obj_typewriter_manager.createid++;
	return (obj_typewriter_manager.createid);
}

///typewriter用のフォントを取得します
///@arg {String} tag
///@return {Struct.TCFontData}
function typewriter_font_get(_tag)
{
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
function typewriter_anim_get(_type, _name)
{
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

///デフォルトフォントを返します
///@return {String}
function typewriter_get_defaultfont()
{
	return obj_typewriter_manager.default_font;
}


///現在選択中のIDを返します
///@return {Real}
function typewriter_get_choice()
{
	return -1;
}

///choice heartの位置調整
///@arg {Real} x
///@arg {Real} y
function typewriter_choice_set_heartpos(_x, _y)
{
	obj_typewriter_manager.choice_heartpos.set(_x, _y);
}

///現在選択しているchoiceの設定したタグ
///@return {String}
function typewriter_choice_get_id()
{
	with (obj_typewriter_manager) if instance_exists(choicedata) {
		return choicedata.data.choice_id; 
	}
	return "";
}

///choice変更時トリガー
///@return {Bool}
function typewriter_choice_changed()
{
	return obj_typewriter_manager.choice_changed;
}

///choice位置を一番上から左のものに変更
///@return {Real}
function typewriter_choice_resettarget()
{
	var _pos, _toplist = [], _next = infinity, _sel;
	with (obj_typewriter_object){
		_pos = data.choice;
		if (_pos.y <= _next){
			_next = _pos.y;
			array_push(_toplist, id)
		}
		
	}
	_next = infinity;
	for (var i = 0; i < array_length(_toplist); i++) {
		_pos = _toplist[i].data.choice;
		if (_pos.x < _next){
			_next = _pos.x;
			_sel = i;
		}
	}
	obj_typewriter_manager.choicedata = _toplist[_sel];
}