///@arg {real} x
///@arg {real} y
///@arg {string} text
function typer_create(_x, _y, _text){
	//var _typer = instance_create_depth(_x, _y, 0, obj_typer);
	//_typer.text = _text;
	//if (instance_exists(obj_battle)){
	//	_typer.battle_surface = true;
	//}
	//return _typer;
}

///@arg {Array} cmd
function get_cmdresult(cmd){
	
}

///@arg {String} text
///@return {Array<Struct.TextData>}
function text_deserialize(text){
	var _char, _cmd,
		_data = [],
		_td = new TextData(),
		_str = "";
	
	for (var i = 1; i <= string_length(text); i++) {
		_char = string_char_at(text, i)
		if (string_char_contains(_char, "<[")){
			_td.set_string(_data, _str);
			_str = "";
			
			while (string_char_contains(_char, "<[")){
				//cmd
				if (_char == "<"){
					_cmd = _td.get_data(i, "<>", text);
					i += _cmd[1]
					_td.set_cmd(_data, _cmd[0]);
				}
				//l10n
				else if (_char == "["){
					_cmd = _td.get_data(i, "[]", text);
					i += _cmd[1]
					_td.set_l10n(_data, _cmd[0]);
				}
				i++
				_char = string_char_at(text, i)
			}
		}
		_str += _char;
	}
	_td.set_string(_data, _str);
	return _data;
}

function TextData() constructor{
	
	///@arg {Array} data
	///@arg {String} str
	static set_string = function (data, str) {
		if (str != "") array_push(data, { type : "str", data : str });
	}
	
	///@arg {Array} data
	///@arg {Array} cmd
	static set_cmd = function (data, cmd) {
		if (!array_empty(cmd) && cmd[0] != "") array_push(data, { type : "cmd", data : cmd });
	}
	
	///@arg {Array} data
	///@arg {Array} l10n
	static set_l10n = function (data, l10n) {
		if (!array_empty(l10n) && l10n[0] != "") array_push(data, { type : "l10n", data : l10n });
	}
	
	///@arg {Real} pos readstart position
	///@arg {String} cmdchars example: "<>"
	///@arg {String} text alltext
	///@return {Array<Any>}
	static get_data = function (pos, cmdchars, text) {
		var _startpos = pos,
			_cmd = [],
			_str = "",
			_char = string_char_at(text, pos),
			_nest = 0,
			_cmdchars = [
				string_char_at(cmdchars, 1),
				string_char_at(cmdchars, 2)
			];
		
		do {
			pos++
			_char = string_char_at(text, pos);
			if (_nest == 0 && (_char == " " || _char == _cmdchars[1])){
				array_push(_cmd, _str);
				_str = "";
			}else{
				_str += _char;
				if (_char == _cmdchars[0]) _nest++
				if (_char == _cmdchars[1]){
					_nest--
					_char = ""
				}
			}
		} until (_nest == 0 && (_char == _cmdchars[1]));
		
		return [_cmd, pos - _startpos];
	}
}

///////////////////////////////////////////////////////
// typewriter

///@ignore
function TypeWriter() constructor{
	x = 0;
	y = 0;
	depth = 0;
	textdata = [];
	font = "";
	gui = false;
	color = c_white;
	scale = new Vector2();
	offset = new Vector2();
	
	///GUI描画を有効にするかどうか
	///@arg {Bool} enable
	///@return {Struct.TypeWriterBuilder}
	static set_gui = function(_enable){
		gui = _enable;
		return self;
	}
	
	///@arg {Asset.GMFont|String} font
	///@return {Struct.TypeWriterBuilder}
	static set_font = function(_font){
		if (is_string(_font)){
			font = _font;
		}else if (asset_get_type(_font) == asset_font){
			font = _font;
		}else{
			throw "指定されたものはフォントではありません"
		}
		return self;
	}
	
	///@arg {Constant.Color} color
	///@return {Struct.TypeWriterBuilder}
	static set_color = function(_color){
		color = _color;
		return self;
	}
	
	///@arg {Real} h
	///@arg {Real} v
	///@return {Struct.TypeWriterBuilder}
	static set_scale = function(_h, _v){
		scale.set(_h, _v);
		return self;
	}
	
	///@arg {Real} x
	///@arg {Real} y
	///@return {Struct.TypeWriterBuilder}
	static set_offset = function(_x, _y){
		offset.set(_x, _y);
		return self;
	}
}

///@arg {Real} x
///@arg {Real} y
///@arg {Array<Struct.TextData>} y
function TypeWriterBuilder(_x, _y, _text) : TypeWriter() constructor{
	x = _x;
	y = _y;
	textdata = _text;
	
	static build = function(){
		var _data = new TypeWriterData(self);
		array_push(obj_typewriter_manager.list, _data);
	}
}

///@ignore
///@arg {Struct.TypeWriterBuilder} type_writer_builder
function TypeWriterData(_self) : TypeWriter() constructor{
	
	var _lists = variable_struct_get_names(self);
	
	array_foreach(_lists, method(_self, function(_e){
		other[$_e] = self[$_e];
	}))
	
	charpos = 0;
	read = 0;
	chars = [];
	
	///@return {Asset.GMFont}
	static get_textdata = function(){
		return textdata[read];
	}
	
	///@return {Asset.GMFont}
	static next_read = function(){
		read++
		return get_textdata();
	}
	
	///@return {Asset.GMFont}
	static add_chars = function(_x, _y, _char){
		array_push(chars, _char);
	}

	///@return {String}
	static read_char = function(_x, _y, _char){
		array_push(chars, _char);
	}
	
	///@return {Asset.GMFont}
	static draw = function(){
		for (var i = 0; i < array_length(chars); i++) {
			
		}
	}
}



