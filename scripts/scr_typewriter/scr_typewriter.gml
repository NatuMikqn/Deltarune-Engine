///@ignore
function TypeWriter() constructor{
	//文字変数
	pos = new Vector2();
	startpos = new Vector2();
	depth = 0;
	textdata = [];
	font = "default";
	color = array_create(4, c_white);
	alpha = 1;
	scale = new Vector2(1);
	offset = new Vector2();
	lang = lang_get();
	
	//声
	voice = snd_text;
	//文字送りの速度
	speed = 3;
	//文字送りタイマー
	sleep = 0;
	//スキップ可能か
	skippable = true;
	//識別用タグ
	tag = "";
	//描画系
	gui = false;
	surface = -1;
	
	///GUI描画を有効にするかどうか
	///@arg {Bool} enable
	///@return {Struct.TypeWriterBuilder}
	static set_gui = function(_enable){
		gui = _enable;
		return self;
	}
	
	///描画対象となるsurfaceを設定する
	///-1で指定しない
	///@arg {Id.Surface} surface_id
	///@return {Struct.TypeWriterBuilder}
	static set_surface = function(_surface){
		surface = _surface;
		return self;
	}
	
	///初期フォントを指定
	///`scr_typer_custom_font`で設定したタグを指定してください
	///@arg {String} font default : "default"
	///@return {Struct.TypeWriterBuilder}
	static set_font = function(_font){
		font = _font;
		return self;
	}
	
	///スキップ可能にするかどうか
	///@arg {Bool} skippable default : true
	///@return {Struct.TypeWriterBuilder}
	static set_skippable = function(_skippable){
		skippable = _skippable;
		return self;
	}
	
	///初期ボイスを指定
	///@arg {Asset.GMSound} voice default : snd_text
	///@return {Struct.TypeWriterBuilder}
	static set_voice = function(_voice){
		voice = _voice;
		return self;
	}
	
	///言語を上書き設定します
	///@arg {Real} lang default : get_lang()
	///@return {Struct.TypeWriterBuilder}
	static set_lang = function(_lang){
		lang = _lang;
		return self;
	}
}

///@arg {Real} x
///@arg {Real} y
///@arg {String} text
function TypeWriterBuilder(_x, _y, _text) : TypeWriter() constructor{
	pos.set(_x, _y);
	startpos.set(_x, _y);
	textdata = text_deserialize(_text);
	
	///@arg {String} tag
	///@return {Struct.TypeWriterBuilder}
	static set_tag = function(_tag){
		tag = _tag;
		return self;
	}
	
	static build = function(){
		var _data = new TypeWriterData(self);
		array_push(obj_typewriter_manager.list, _data);
		return _data;
	}
}

///@ignore
///@arg {Struct.TypeWriterBuilder} type_writer_builder
function TypeWriterData(_self) : TypeWriter() constructor{
	
	var _lists = variable_struct_get_names(self);
	
	array_foreach(_lists, method(_self, function(_e){
		other[$_e] = self[$_e];
	}))
	
	//文字読み取り位置
	read = 0;
	//段階読み取り位置
	step = 0;
	//文字データリスト
	chars = [];
	//決定キーの有効化
	interaction = true;
	//スキップ中か
	skipped = false;
	//文字送り停止中かどうか
	paused = false;
	//メタトンのような文字送り
	mtt_mode = false;
	mtt_already_voice = false;
	
	///現在のテキストデータからl10nを実行
	static l10n = function(){
		var _data = textdata[step].data
		var _text = _data[0]
		array_delete(_data, 0, 1)
		textdata[step] = get_textdata_format("str", get_text(_text, _data));
		step--;
	}
	
	///次の文字を読み取ることはできるか
	///@return {Bool}
	static can_read = function(){
		if (is_end() || paused) return false;
		
		if (sleep > 0){
			sleep--;
			if (sleep <= 0 || skipped){
				return true;
			}else{
				return false;
			}
		}
		return true;
	}
	
	///スキップが開始できるならば、スキップをする
	static start_skip = function(){
		if (skippable && !paused) {
			skipped = true;
			sleep = 0;
		}
	}
	
	///sleep checker
	static resume = function(){
		if (interaction) {
			paused = false;
		}
	}
	
	///sleep add
	static sleep_add = function(){
		if (!skipped && (!mtt_mode || (mtt_mode && mtt_sleepcheck()))){
			sleep += speed;
			mtt_already_voice = false;
		}
	}
	
	///文字送りを停止する
	static pause = function(){
		paused = true;
		skipped = false;
		mtt_already_voice = false;
	}
	
	///現在のテキストデータを取得
	///@return {Struct.TextData}
	static get_textdata = function(){
		return textdata[step];
	}
	
	///テキストデータの読み取りが終了したかどうか
	///@return {Bool}
	static is_end = function(){
		return (array_length(textdata) <= step);
	}
	
	///ステップを進め、次のテキストデータを読み取る
	///@return {Struct.TextData}
	static next_step = function(){
		step++
		return get_textdata();
	}
	
	///今の文字は空白であるかどうか
	///@return {Bool}
	///@pure
	static mtt_sleepcheck = function(){
		return (textdata[step].type == "str" && string_char_at(textdata[step].data, read) == " ");
	}

	///指定されたタグとこのTypeWriterのタグが一致するかどうか
	///@arg {String} tag
	///@return {Bool}
	///@pure
	static tag_equals = function(_tag){
		return (tag == _tag);
	}
	
	///文字データを追加
	static add_chars = function(){
		read++;
		var _char = string_char_at(textdata[step].data, read),
			_font = typewriter_font_get(font).get_font(lang);
		var _data = new CharData(pos, _char, color, scale, alpha, _font);
		
		//x位置を_charの横幅 + 字間進める
		var _w = typewriter_font_get(font).get_sp_char(lang);
		draw_set_font(_font);
		_w += string_width(_char) * scale.x;
		
		pos.x += _w;
		
		array_push(chars, _data);
		
		if (!skipped && !mtt_already_voice && _char != " "){
			audio_play_sound(voice, 0, 0);
			mtt_already_voice = true;
		}
		
		if (string_length(textdata[step].data) <= read){
			step++;
			read = 0;
		}
	}
	
	///改行を行う
	static newline = function(){
		//x位置を作成時のx位置に戻す
		pos.x = startpos.x;
		//y位置を"A"の縦幅 + 行間下げる
		var _font = draw_get_font();
		
		var _h = typewriter_font_get(font).get_sp_line(lang);
		draw_set_font(typewriter_font_get(font).get_font(lang));
		_h += string_height("A") * scale.y;
		
		pos.y += _h;
		
		draw_set_font(_font)
	}
	
	///描画
	static draw = function(){
		var _chardata, _pos, _scale, _offset, _color;
		for (var i = 0; i < array_length(chars); i++) {
			_chardata = chars[i];
			draw_set_font(_chardata.get_font())
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

///@arg {Struct.Vector2} pos
///@arg {String} char
///@arg {Array<Constant.Color>} color
///@arg {Struct.Vector2} scale
///@arg {Real} alpha
///@arg {Asset.GMFont} font
function CharData(_pos, _char, _color, _scale, _alpha, _font) : TypeWriter() constructor{
	pos = _pos.copy();
	char = _char;
	color = _color;
	scale = _scale;
	alpha = _alpha;
	font = _font;
	offset = new Vector2();
	
	static get_char = function(){ return char; }
	
	static get_pos = function(){ return pos; }
	
	static get_scale = function(){ return scale; }
	
	static get_offset = function(){ return offset; }
	static set_offset = function(_value){ offset = _value; }
	
	static get_alpha = function(){ return alpha; }
	
	static get_color = function(){ return color; }
	
	static get_font = function(){ return font; }
	
	
}

