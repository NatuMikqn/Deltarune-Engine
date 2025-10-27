
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
///指定したタグが付いているtypewriterリストを取得します
///@arg {String} tag
///@return {Array<Id.Instance>}
function typewriter_get_ext(_tag)
{
	var _list = [];
	with (obj_typewriter_object){
		if (data.tag_equals(_tag)){
			array_push(_list, id);
		}
	}
	return _list;
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

///選択時のソウルの相対位置を設定
///@arg {Real} x
///@arg {Real} y
function typewriter_choice_set_heartpos(_x, _y)
{
	obj_typewriter_manager.choice_heartpos.set(_x, _y);
}

///現在選択しているchoiceの設定したID
///@return {Real}
function typewriter_choice_get_id()
{
	with (obj_typewriter_manager) if instance_exists(choicedata) {
		return choicedata.data.choice_id; 
	}
	return undefined;
}

///choice変更時のFunction指定
///空白の場合、無効にします
///@arg {Function} func
function typewriter_choice_changed(func = undefined)
{
	obj_typewriter_manager.func_change = func;
}

///choiceが端についたときに最初に戻るかどうか
///垂直用
///@arg {Bool}
function typewriter_choice_enable_reverse_h(_enable)
{
	obj_typewriter_manager.reverse.x = _enable;
}

///choiceが端についたときに最初に戻るかどうか
///水平用
///@arg {Bool}
function typewriter_choice_enable_reverse_v(_enable)
{
	obj_typewriter_manager.reverse.y = _enable;
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