///タイプライター用のフォントを追加します
///@arg {String} name
function TyperCustomFont(_name) constructor {
	name = _name;
	
	fonts = [];
	
	///フォントデータの追加
	///@arg {Struct.TyperFontData} fontdata
	///@return {Struct.TyperCustomFont}
	static add_font = function (_fontdata){
		array_push(fonts, _fontdata);
		return self;
	}
	
	///フォントの登録
	static register = function (){
		array_push(obj_typewriter_manager.font_list, fonts)
	}
}

///@arg {Real} lang LANG.?
///タイプライター用のフォントデータを作成します
function TyperFontData(_lang) constructor {
	font = [];
	lang = _lang;
	
	xscale = 1;
	yscale = 1;
	spacew = 0;
	
	///フォントの設定
	///.ttfファイルのファイルを指定することも可能です
	///フォントを適応する範囲を指定することも可能です
	///@arg {Asset.GMFont} font AssetFont
	///@arg {Real} start rangeStart
	///@arg {Real} end rangeEnd
	///@return {Struct.TyperFontData}
	static add_font = function (_font, _start = -1, _end = -1){
		var _data = {
			font : _font,
			first : _start,
			last : _end
		}
		array_push(font, _data);
		
		return self;
	}
	
	///フォントの設定
	///.ttfファイルがあるファイルパスから自動生成をします
	///@arg {String} font FilePath
	///@arg {Real} size size
	///@arg {Real} start rangeStart
	///@arg {Real} end rangeEnd
	///@return {Struct.TyperFontData}
	static add_font_ttf = function (_font, _size, _start, _end){
		if (!file_exists(_font)) throw "doesn't exists font.ttf"
		var _assetfont = font_add(_font, _size, false, false, _start, _end);
		add_font(_assetfont, _start, _end)
		
		return self;
	}
}