///@ignore
function TyperCustomFont() constructor
{
	font = -1;
	
	asterisk = [["*", "＊"]];
	space = [[" ", "　"]];
	
	spacing = {
		char : [],
		line : []
	};
	width = {
		char : [],
		space : [],
		asterisk: []
	};
	
	globalmode = false;
}

///タイプライター用のフォントを追加します
///@arg {String} tag
///@arg {Asset.GMFont|String} font Asset or l10nFont(StringName)
function TCFontBuilder(_tag, _font) : TyperCustomFont() constructor
{
	tag = _tag;
	font = _font;
	
	lang = 0;
	
	///言語に依存しないようにするかどうか
	///@arg {Bool} enable
	///@return {Struct.TCFontBuilder}
	static set_global = function (_enable){
		globalmode = _enable;
		if (globalmode) lang = 0;
		return self;
	}
	///編集対象の言語指定
	///グローバルモードの場合、この設定は意味を成しません
	///@arg {Real} lang
	///@return {Struct.TCFontBuilder}
	static target_lang = function (_lang){
		if (!globalmode) lang = _lang;
		return self;
	}
	
	///字間設定
	///@arg {Real} spacing
	///@return {Struct.TCFontBuilder}
	static set_sp_char = function (_s){
		spacing.char[lang] = _s;
		return self;
	}
	///行間設定
	///@arg {Real} spacing
	///@return {Struct.TCFontBuilder}
	static set_sp_line = function (_s){
		spacing.line[lang] = _s;
		return self;
	}
	///基本文字の文字幅設定
	///@arg {Real} spacing
	///@return {Struct.TCFontBuilder}
	static set_w_char = function (_s){
		width.char[lang] = _s;
		return self;
	}
	///スペース文字の文字幅設定
	///@arg {Real} spacing
	///@return {Struct.TCFontBuilder}
	static set_w_space = function (_s){
		width.space[lang] = _s;
		return self;
	}
	///アスタリスク文字の文字幅設定
	///@arg {Real} spacing
	///@return {Struct.TCFontBuilder}
	static set_w_asterisk = function (_s){
		width.asterisk[lang] = _s;
		return self;
	}
	
	///アスタリスク文字の設定
	///@arg {Array<String>} asterisk_list
	///@return {Struct.TCFontBuilder}
	static set_asterisk = function (_al){
		asterisk[lang] = _al;
		return self;
	}
	///空白文字の設定
	///@arg {Array<String>} space_list
	///@return {Struct.TCFontBuilder}
	static set_space = function (_sl){
		space[lang] = _sl;
		return self;
	}
	
	///フォントの登録
	static build = function () {
		var _data = new TCFontData(self);
		obj_typewriter_manager.font_list[$ tag] = _data;
	}
}

///@ignore
///@arg {Struct.TCFontBuilder} builder
function TCFontData(_self) : TyperCustomFont() constructor
{
	var _lists = variable_struct_get_names(self);
	
	array_foreach(_lists, method(_self, function(_e){
		other[$_e] = self[$_e];
	}))
	
	///フォントを返します
	///@return {Asset.GMFont}
	static get_font = function (_lang = lang_get()) { return l10n_get_font(font, _lang); }
	
	///字間を返します
	///@arg {Real} lang default : lang_get()
	///@return {Real}
	static get_sp_char = function (_lang = lang_get()) { return spacing.char[_lang]; }
	///行間を返します
	///@arg {Real} lang default : lang_get()
	///@return {Real}
	static get_sp_line = function (_lang = lang_get()) { return spacing.line[_lang]; }
	///文字幅を返します
	///@arg {Real} lang default : lang_get()
	///@return {Real}
	static get_w_char = function (_lang = lang_get()) { return width.char[_lang]; }
	///空白文字用の文字幅を返します
	///@arg {Real} lang default : lang_get()
	///@return {Real}
	static get_w_space = function (_lang = lang_get()) { return width.space[_lang]; }
	///空白文字用の文字幅を返します
	///@arg {Real} lang default : lang_get()
	///@return {Real}
	static get_w_asterisk = function (_lang = lang_get()) { return width.space[_lang]; }
	
	///アスタリスク文字のリストを返します
	///@return {Array<String>}
	static get_asterisk = function (_lang = lang_get()){
		if (_lang < array_length(asterisk)) return (asterisk[_lang] ?? asterisk[0]);
		return asterisk[0];
	}
	
	///空白文字のリストを返します
	///@return {Array<String>}
	static get_space = function (_lang = lang_get()){
		if (_lang < array_length(space)) return (space[_lang] ?? space[0]);
		return space[0];
	}

	///グローバグフォントかどうか
	///@return {Bool}
	static get_globalmode = function (){ return globalmode; }
}