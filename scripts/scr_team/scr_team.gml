enum TEAMCHAR{
	KRIS,
	SUSIE,
	RALSEI,
	NOELLE
}
enum TEAMCHAR_FLAG{
	HEALTH,
	MAX_HEALTH,
	COLOR,
	AREA_OBJ,
	BATTLE_OBJ,
	
	ENCOUNTER_X,
	ENCOUNTER_Y,
	BATTLE_X,
	BATTLE_Y
}

function team_init()
{
	global.char_data = {};
	global.team_list = [];
	global.team_buttons = {};
	global.team_buttongroup = {};
}

///@ignore
function CharacterInfo() constructor
{
	tag = "";
	hp = 100;
	maxhp = 100;
	color = c_orange;
	object = {
		arena : obj_char_player,
		battle : obj_battle_team_kris
	}
	buttonlist = [];
	
	pos = {
		encount : new Vector2(),
		battle : new Vector2(),
	}
	charbox_info = {
		icon : spr_missing,
		name : spr_missing
	}
}

///@arg {String} tag
function CharacterInfoBuilder(_tag) : CharacterInfo() constructor
{
	tag = _tag;
	
	///@arg {Real} hp
	static set_hp = function(_val){
		hp = _val;
		maxhp = _val;
		return self;
	}
	///@arg {Real|Constant.Color} color
	static set_color = function(_val){
		color = _val;
		return self;
	}
	///@arg {Asset.GMObject} obj
	static set_obj_arena = function(_val){
		object.arena = _val;
		return self;
	}
	///@arg {Asset.GMObject} obj
	static set_obj_battle = function(_val){
		object.battle = _val;
		return self;
	}
	///@arg {String} button_list array copy
	static apply_button = function(_val){
		buttonlist = team_get_buttongroup(_val);
		return self;
	}
	///@arg {Asset.GMSprite|String} iconsprite
	///@arg {Asset.GMSprite|String} namesprite
	static set_charbox_info = function(_icon, _name){
		charbox_info.icon = _icon;
		charbox_info.name = _name;
		return self;
	}
	
	static build = function(){
		var _data = new CharacterInfoData(self);
		global.char_data[$ tag] = _data;
	}
}

///@ignore
///@arg {Struct.CharacterInfoBuilder} teaminfo
function CharacterInfoData(_self) : CharacterInfo() constructor
{
	send_builder_to_data(_self);
	
	static equals_tag = function(_tag){ return tag == _tag; }
	static get_hp = function(){ return hp; }
	static get_maxhp = function(){ return maxhp; }
	static get_color = function(){ return color; }
	static get_obj_arena = function(){ return object.arena; }
	static get_obj_battle = function(){ return object.battle; }
	///@return {Array<Struct.ButtonInfo>}
	static get_buttonlist = function(){ return buttonlist; }
	static get_charbox_iconsprite = function()
	{
		var _spr = charbox_info.icon;
		if (is_string(_spr)) _spr = l10n_get_sprite(_spr);
		return _spr;
	}
	static get_charbox_namesprite = function()
	{
		var _spr = charbox_info.name;
		if (is_string(_spr)) _spr = l10n_get_sprite(_spr);
		return _spr;
	}
	 
	static set_position_encounter = function(_x, _y){ pos.encount.set(_x, _y); }
	static set_position_battle = function(_x, _y){ pos.battle.set(_x, _y); }
	static get_position_encounter = function(){ return pos.encount; }
	static get_position_battle = function(){ return pos.battle; }
}

///@arg {String} character_id
function team_join(_char_id)
{
	if (struct_exists(global.char_data, _char_id))
		array_push(global.team_list, variable_clone(global.char_data[$_char_id]));
	else
		throw "Unknown TeamChar ID"
}

///現在のチームリストを取得
///@return {Array<Struct.CharacterInfoData>}
///@pure
function team_get()
{
	return global.team_list;
}


///現在のチームリストの長さを取得
///@return {real}
function team_get_count()
{
	return array_length(team_get());
}

///チームリストを白紙にする
function team_clear()
{
	global.team_list = [];
}

///チームを退出させる
///何番目のキャラクターかを指定することもできます
///@arg {String} tag
///@arg {Real} order
function team_leave(_tag, _order = 0)
{
	var _team = team_get(),
		_temp_pos = 0;
	for (var i = 0; i < array_length(_team); i++) {
		if (_team[i].equals_tag(_tag)){
			_temp_pos = i;
			if (_order <= 0) break;
			_order--;
		}
	}
	array_delete(_team, _temp_pos, 1);
}

///@arg {String} character
///@arg {any} default
///@return {any}
function team_get_data(_char, _flag, _def = undefined)
{
	if struct_exists(global.char_data, _char){
		
		var _chardata = global.char_data[_char];
		
		if array_exists(_chardata, _flag){
			return global.char_data[_char][_flag];
		}else{
			return _def;
		}
	}else{
		return _def;
	}
}

///@arg {Real} type
///@arg {String|Asset.GMSprite} sprite
function ButtonInfo(_type, _spr) constructor
{
	type = _type;
	sprite = _spr;
	
	///@return {Real} type
	static get_type = function(){ return type; };
	///@return {Asset.GMSprite} sprite
	static get_sprite = function(){ return l10n_get_sprite(sprite); };
}

///@arg {String} name
///@arg {Struct.ButtonInfo} data
function team_button_register(_name, _data)
{
	global.team_buttons[$ _name] = _data;
}

///@arg {String} name
///@arg {Array<String>} data
function team_buttongroup_register(_name, _data)
{
	var _result = [];
	for (var i = 0; i < array_length(_data); i++) {
		array_push(_result, team_get_button(_data[i]));
	}
	global.team_buttongroup[$ _name] = _result;
}

///@arg {String} name
///@return {Struct.ButtonInfo}
function team_get_button(_name)
{
	return global.team_buttons[$ _name];
}

///@arg {String} name
///@return {Array<Struct.ButtonInfo>}
function team_get_buttongroup(_name)
{
	return global.team_buttongroup[$ _name];
}