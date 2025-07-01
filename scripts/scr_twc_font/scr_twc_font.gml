///@ignore
function TyperCustomFont() constructor
{
	name = "";
	font = -1;
	
	asterisk = ["*", "＊"];
	space = [" ", "　"];
	
	spacing = {
		char : [],
		line : []
	};
}

///タイプライター用のフォントを追加します
///@arg {String} name
///@arg {Asset.GMFont|String} font Asset or l10nFont(StringName)
function TCFBuilder(_name, _font) : TyperCustomFont() constructor
{
	name = _name;
	font = _font;
	
	///字間設定
	///@arg {Real} lang
	///@arg {Real} spacing
	///@return {Struct.TCFBuilder}
	static set_spacing_char = function (_lang, _s){
		spacing.char[_lang] = _s;
		return self;
	}
	///字間設定
	///@arg {Real} lang
	///@arg {Real} spacing
	///@return {Struct.TCFBuilder}
	static set_spacing_line = function (_lang, _s){
		spacing.line[_lang] = _s;
		return self;
	}
	
	///アスタリスク文字の設定
	///@arg {Array<String>} asterisk_list
	///@return {Struct.TCFBuilder}
	static set_asterisk = function (_al){
		asterisk = _al;
		return self;
	}
	
	///空白文字の設定
	///@arg {Array<String>} space_list
	///@return {Struct.TCFBuilder}
	static set_space = function (_sl){
		space = _sl;
		return self;
	}
	
	///フォントの登録
	static register = function () {
		var _data = new TCFData(self);
		array_push(obj_typewriter_manager.font_list, fonts);
	}
}

///@ignore
///@arg {Struct.TCFBuilder} builder
function TCFData(_self) : TyperCustomFont() constructor
{
	var _lists = variable_struct_get_names(self);
	
	array_foreach(_lists, method(_self, function(_e){
		other[$_e] = self[$_e];
	}))
	
}