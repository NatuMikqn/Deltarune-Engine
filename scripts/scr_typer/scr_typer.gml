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

///@ignore
function TypeWriter() constructor{
	x = 0;
	y = 0;
	depth = 0;
	textdata = "";
	font = "";
	gui = false;
}

function TypeWriterBuilder() : TypeWriter() constructor{
	
	///@arg {Array<Struct.TextData>} text
	static set_text = function(_text){
		textdata = _text;
		return self;
	}
	///@arg {Asset.GMFont,String} font
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
	static build = function(){
		var _data = new TypeWriterData(self);
		//TODO - データを登録するコードを書く
	}
}

///@ignore
///@arg {Struct.TypeWriterBuilder} type_writer_builder
function TypeWriterData(_self) : TypeWriter() constructor{
	
	var _lists = variable_struct_get_names(self);
	
	array_foreach(_lists, method(_self, function(_e){
		other[$_e] = self[$_e];
	}))
	
	static get_text = function(){
		return font;
	}
}



