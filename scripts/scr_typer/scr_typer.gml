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



