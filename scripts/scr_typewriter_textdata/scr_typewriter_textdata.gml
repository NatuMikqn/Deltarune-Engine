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

///@arg {String} type
///@arg {Any} data
function get_textdata_format(type, data){
	return { type : type, data : data }
}

///@arg {String} text
///@return {Array<Struct.TextData>}
function text_deserialize(text){
	var _char, _cmd, _text, _str = "",
		_data = [],
		_td = new TextData();
	
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
					i++
				}
				//l10n
				else if (_char == "["){
					_cmd = _td.get_data(i, "[]", text);
					text = string_delete(text, i, _cmd[1] + 1);
					
					_text = _cmd[0][0]
					array_delete(_cmd[0], 0, 1)
					
					text = string_insert(l10n_get_text(_text, _cmd[0]), text, i);
				}
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
		if (str != "") array_push(data, get_textdata_format("str", str));
	}
	
	///@arg {Array} data
	///@arg {Array} cmd
	static set_cmd = function (data, cmd) {
		if (!array_empty(cmd) && cmd[0] != "") array_push(data, get_textdata_format("cmd", cmd));
	}
	
	///@arg {Real} pos readstart position
	///@arg {String} cmdchars example: "<>"
	///@arg {String} text alltext
	///@return {Array<Any>}
	static get_data = function (pos, cmdchars, text) {
		var _startpos = pos, _cmd = [], _str = "", _nest = 0,
			_char = string_char_at(text, pos),
			_cmdchars = [
				string_char_at(cmdchars, 1),
				string_char_at(cmdchars, 2)
			];
		
		do {
			pos++
			_char = string_char_at(text, pos);
			if (_nest == 0 && (_char == " " || _char == _cmdchars[1])){
				//float check
				if (string_is_real(_str))_str = real(string_real(_str));
				//bool check
				else if (string_is_bool(_str)) _str = bool(_str);
				
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
