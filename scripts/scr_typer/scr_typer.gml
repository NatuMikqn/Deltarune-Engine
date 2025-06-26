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
		if (str != "") array_push(data, get_textdata_format("str", str));
	}
	
	///@arg {Array} data
	///@arg {Array} cmd
	static set_cmd = function (data, cmd) {
		if (!array_empty(cmd) && cmd[0] != "") array_push(data, get_textdata_format("cmd", cmd));
	}
	
	///@arg {Array} data
	///@arg {Array} l10n
	static set_l10n = function (data, l10n) {
		if (!array_empty(l10n) && l10n[0] != "") array_push(data, get_textdata_format("l10n", l10n));
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
	//文字座標
	pos = new Vector2();
	startpos = new Vector2();
	depth = 0;
	textdata = [];
	font = fnt_8bit;
	gui = false;
	color = c_white;
	alpha = 1;
	scale = new Vector2(1);
	offset = new Vector2();
	
	voice = snd_text;
	speed = 3;
	sleep = 0;
	
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
	
	///@arg {Asset.GMSound} voice
	///@return {Struct.TypeWriterBuilder}
	static set_voice = function(_voice){
		color = _voice;
		return self;
	}
}

///@arg {Real} x
///@arg {Real} y
///@arg {Array<Struct.TextData>} y
function TypeWriterBuilder(_x, _y, _text) : TypeWriter() constructor{
	pos.set(_x, _y);
	startpos.set(_x, _y);
	textdata = _text;
	
	static build = function(){
		var _data = new TypeWriterData(self);
		array_push(obj_typewriter_manager.list, _data);
		return _data;
	}
}

///@arg {Struct.Vector2} pos
///@arg {String} char
///@arg {Constant.Color} color
///@arg {Struct.Vector2} scale
///@arg {Real} alpha
function CharData(_pos, _char, _color, _scale, _alpha) : TypeWriter() constructor{
	pos = _pos.copy();
	char = _char;
	color = color_converter(_color);
	scale = _scale;
	alpha = _alpha;
	offset = new Vector2();
	
	static get_char = function(){ return char; }
	
	static get_pos = function(){ return pos; }
	
	static get_scale = function(){ return scale; }
	
	static get_offset = function(){ return offset; }
	static set_offset = function(_value){ offset = _value; }
	
	static get_alpha = function(){ return alpha; }
	
	static get_color = function(){ return color; }
	
	
}

///@ignore
///@arg {Struct.TypeWriterBuilder} type_writer_builder
function TypeWriterData(_self) : TypeWriter() constructor{
	
	var _lists = variable_struct_get_names(self);
	
	array_foreach(_lists, method(_self, function(_e){
		other[$_e] = self[$_e];
	}))
	
	//文字読み取り位置
	charpos = 0;
	//
	read = 0;
	//文字データリスト
	chars = [];
	
	///現在のテキストデータからl10nを実行
	static l10n = function(){
		var _text = textdata[read].data
		textdata[read] = get_textdata_format("str", _text[0]);
		read--;
	}
	
	///
	///@return {Bool}
	static is_sleep = function(){
		sleep--;
		if (sleep > 0){
			return true;
		}
		return false;
	}
	
	///現在のテキストデータを取得
	///@return {Struct.TextData}
	static get_textdata = function(){
		return textdata[read];
	}
	
	///テキストデータの読み取りが終了したかどうか
	///@return {Bool}
	static is_end = function(){
		return (array_length(textdata) <= read);
	}
	
	///次のテキストデータを読み取る
	///@return {Struct.TextData}
	static next_read = function(){
		read++
		return get_textdata();
	}
	
	///文字データを追加
	static add_chars = function(){
		charpos++;
		var _char = string_char_at(textdata[read].data, charpos);
		var _data = new CharData(pos, _char, color, scale, alpha);
		pos.x += string_width(_char) * scale.x;
		array_push(chars, _data);
		
		audio_play_sound(voice, 0, 0);
		
		if (string_length(textdata[read].data) <= charpos){
			read++;
			charpos = 0;
		}
	}
	
	///改行
	static newline = function(){
		pos.x = startpos.x;
		var _font = draw_get_font();
		pos.y += string_height("A") * scale.y;
		draw_set_font(_font)
	}
	
	///描画
	static draw = function(){
		var _chardata, _pos, _scale, _offset, _color;
		for (var i = 0; i < array_length(chars); i++) {
			_chardata = chars[i];
			_pos = _chardata.get_pos();
			_scale = _chardata.get_scale();
			_offset = _chardata.get_offset();
			_color = _chardata.get_color();
			draw_text_transformed_color(_pos.x, _pos.y, _chardata.get_char(), _scale.x, _scale.y, 0,
				_color[0], _color[1], _color[2], _color[3], _chardata.get_alpha()
			);
		}
	}
}



