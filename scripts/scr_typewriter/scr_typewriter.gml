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
	globalmode = false;
	
	anim = {
		create: undefined,
		typerstep: undefined,
		charstep: undefined
	}
	anim_arg = {
		create: [],
		typerstep: [],
		charstep: []
	}
	
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
	//文字が生成されたタイミング
	//TODO: スキップを考慮
	chartimer = 0;
	
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
	readstep = 0;
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
		var _data = textdata[readstep].data
		var _text = _data[0]
		array_delete(_data, 0, 1)
		textdata[readstep] = get_textdata_format("str", l10n_get_text(_text, _data));
		readstep--;
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
		return textdata[readstep];
	}
	
	///テキストデータの読み取りが終了したかどうか
	///@return {Bool}
	static is_end = function(){
		return (array_length(textdata) <= readstep);
	}
	
	///今の文字は空白であるかどうか
	///@return {Bool}
	///@pure
	static mtt_sleepcheck = function(){
		return (textdata[readstep].type == "str" && string_char_at(textdata[readstep].data, read) == " ");
	}

	///指定されたタグとこのTypeWriterのタグが一致するかどうか
	///@arg {String} tag
	///@return {Bool}
	///@pure
	static tag_equals = function(_tag){
		return (tag == _tag);
	}
	
	///改行を行う
	static newline = function(){
		//x位置を作成時のx位置に戻す
		pos.x = startpos.x;
		//y位置を"A"の縦幅 + 行間下げる
		var _font = draw_get_font(),
			_lang = globalmode ? 0 : lang;
		
		var _h = typewriter_font_get(font).get_sp_line(_lang);
		draw_set_font(typewriter_font_get(font).get_font(_lang));
		_h += string_height("A") * scale.y;
		
		pos.y += _h;
		
		draw_set_font(_font)
	}
	
	///文字データを追加
	static add_chars = function(){
		read++;
		var _lang = globalmode ? 0 : lang,
			_char = string_char_at(textdata[readstep].data, read),
			_font = typewriter_font_get(font).get_font(_lang),
			_data = new CharData(pos, _char, color, scale, alpha, _font);
		
		if (is_array(anim.charstep)){
			_data.set_animfunc(anim.charstep[0]);
			_data.set_animargs(anim_arg.charstep);
		}
		
		//Create Function
		if (is_array(anim.create)) {
			_data.run_animcreate(anim.create[0], anim_arg.create)
		}
		
		//x位置を_charの横幅 + 字間進める
		var _w = typewriter_font_get(font).get_sp_char(_lang);
		draw_set_font(_font);
		_w += string_width(_char) * scale.x;
		
		pos.x += _w;
		
		array_push(chars, _data);
		
		if (!skipped && !mtt_already_voice && _char != " "){
			audio_play_sound(voice, 0, 0);
			mtt_already_voice = true;
		}
		
		if (string_length(textdata[readstep].data) <= read){
			readstep++;
			read = 0;
		}
	}
	
	///ステップ
	static step = function(){
		var _cd;
		for (var i = 0; i < array_length(chars); i++) {
			_cd = chars[i];
			//TyperStep Function
			if (is_array(anim.typerstep)) _cd.run_twanimstep(anim.typerstep[0], anim_arg.typerstep);
			//CharStep Function
			_cd.run_animstep();
			
			_cd.add_chartimer()
		}
	}
	
	///描画
	static draw = function(){
		var _pos, _scale, _offset, _color, _alpha;
		for (var i = 0; i < array_length(chars); i++) {
			with(chars[i]){
				draw_set_font(get_font())
				_pos = get_pos();
				_scale = get_scale();
				_offset = get_offset();
				_color = get_color();
				_alpha = get_alpha();
				
				var _finalpos = _pos.copy().add(_offset),
					_offset_user = get_offset_user();
				struct_foreach(_offset_user, method(_finalpos, function (_name, _value) {
						add(_value)
					}))
				
				draw_text_transformed_color(_finalpos.x, _finalpos.y, get_char(), _scale.x, _scale.y, 0,
					_color[0], _color[1], _color[2], _color[3], _alpha
				);
			}
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
	scale = _scale.copy();
	alpha = _alpha;
	font = _font;
	offset = new Vector2();
	offset_user = {};
	create_trigger_once = {
		char : true,
		typer : true
	};
	anim = {
		func : undefined,
		args : []
	}
	chartimer = 0;
	
	///@arg {Function} func
	static set_animfunc = function(func){
		anim.func = func;
		create_trigger_once.char = true;
	}
	///@arg {Array} args
	static set_animargs = function(args){ anim.args = args; }
	
	///@arg {Function} func
	///@arg {Array} args
	static run_animcreate = function(func, args){
		var _args = array_concat([self], args);
		method_call(func, _args);
	}
	
	static run_animstep = function(){
		if (!is_method(anim.func)) return;
		run_sys_animstep(anim.func, anim.args, "char")
	}
	
	///@arg {Function} func
	///@arg {Array} args
	static run_twanimstep = function(func, args){
		run_sys_animstep(func, args, "typer")
	}
	
	///@arg {Function} func
	///@arg {Array} args
	///@arg {String} oncename
	///@ignore
	static run_sys_animstep = function(func, args, oncename){
		var _args = array_concat([self, create_trigger_once[$ oncename]], args);
		method_call(func, _args);
		if (create_trigger_once[$ oncename]){
			create_trigger_once[$ oncename] = false;
		}
	}
	
	static get_char = function(){ return char; }
	
	static get_pos = function(){ return pos; }
	
	static get_scale = function(){ return scale; }
	
	///@return {Struct<Struct.Vector2>}
	static get_offset_user = function(){ return offset_user; }
	
	static get_offset = function(){ return offset; }
	static set_offset = function(_value){ offset = _value; }
	
	static get_alpha = function(){ return alpha; }
	
	static get_color = function(){ return color; }
	
	static get_font = function(){ return font; }
	
	static add_chartimer = function(){ chartimer++; }
	static get_chartimer = function(){ return chartimer; }
	
	
}

