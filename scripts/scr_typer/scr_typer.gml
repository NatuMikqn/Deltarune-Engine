///@arg {real} x
///@arg {real} y
///@arg {string} text
function typer_create(_x, _y, _text){
	var _typer = instance_create_depth(_x, _y, 0, obj_typer);
	_typer.text = _text;
	if (instance_exists(obj_battle)){
		_typer.battle_surface = true;
	}
	return _typer;
}

///@arg {real} x
///@arg {real} y
///@arg {string} text
///@arg {real} choice
///@arg {function} function
function choice_create(_x, _y, _text, _choice, _func){
	var _typer = typer_create(_x, _y, _text)
	_typer.choice = _choice;
	_typer.func = _func;
}

function text_deserialize(_text){
	while(_text){
		
	}
}

//new
function TypeWriter() constructor{
	x = 0;
	y = 0;
	depth = 0;
	textdata = "";
	font = "";
	gui = false;
}

function TypeWriterBuilder() : TypeWriter() constructor{
	
	///@arg {Asset.GMFont,String} text
	static set_text = function(_text){
		if (is_string(_font)){
			font = _font;
		}else if (asset_get_type(_font) == asset_font){
			font = _font;
		}else{
			throw "指定されたものはフォントではありません"
		}
		return self;
	}
	
	///@arg {Struct.Context,String} font
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
	
	///@arg {real} depth
	static set_depth = function(_depth){
		if (!is_real(_depth) && !is_int64(_depth)) throw $"depth > 不正な型です : {_depth}"
		depth = _depth
		return self;
	}
	
	///@arg {bool} gui
	static set_gui = function(_gui){
		if (!is_bool(_gui)) throw $"gui > 不正な型です : {_gui}"
		gui = _gui
		return self;
	}
	
	static build = function(){
		(new TypeWriterData(self));
	}
}

///@ignore
///@arg {Struct.TypeWriterBuilder} type_writer_builder
function TypeWriterData(_self) : TypeWriter() constructor{
	
	var _lists = variable_struct_get_names(self);
	
	array_foreach(_lists, method(_egb, function(_e){
		other[$_e] = self[$_e];
	}))
	
}



