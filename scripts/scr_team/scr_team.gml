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
	color = [c_orange, #FFC060];
	object = {
		area : obj_char_player,
		battle : obj_battle_team_kris
	}
	area_sprite = undefined;
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
	///@arg {Real|Constant.Color} color1
	///@arg {Real|Constant.Color} color2
	static set_color = function(_val1, _val2){
		color = [_val1, _val2];
		return self;
	}
	///@arg {Asset.GMObject} obj
	static get_obj_area = function(_val){
		object.area = _val;
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
	
	static get_tag = function(){ return tag; }
	static equals_tag = function(_tag){ return tag == _tag; }
	static get_hp = function(){ return hp; }
	static get_maxhp = function(){ return maxhp; }
	static get_color_first = function(){ return color[0]; }
	static get_color_second = function(){ return color[1]; }
	static get_color_array = function(){ return color; }
	static get_obj_area = function(){ return object.area; }
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
	 
	///@arg {Real} x
	///@arg {Real} y
	static set_position_encounter = function(_x, _y){ pos.encount.set(_x, _y); }
	///@arg {Real} x
	///@arg {Real} y
	static set_position_battle = function(_x, _y){ pos.battle.set(_x, _y); }
	///@return {Struct.Vector2}
	static get_position_encounter = function(){ return pos.encount; }
	///@return {Struct.Vector2}
	static get_position_battle = function(){ return pos.battle; }
	
	///@arg {Asset.GMSprite} sprite
	static set_area_sprite = function(_spr){ area_sprite = _spr; }
	///@return {Asset.GMSprite}
	static get_area_sprite = function(){ return area_sprite; }
}

///@arg {String} character_tag
function team_join(_tag)
{
	if (struct_exists(global.char_data, _tag))
		array_push(global.team_list, variable_clone(char_get_data(_tag)));
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

///キャラクターデータの取得
///存在しない場合はundefinedが返されます
///@arg {String} character_tag
///@return {Struct.CharacterInfoData}
///@pure
function char_get_data(_tag)
{
	if (struct_exists(global.char_data, _tag)) return global.char_data[$_tag];
	return undefined;
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

///@arg {Real} targetpos char id
///@arg {Real} itemtype item type
///@arg {String} itemtag item name
///@return {Bool}
function char_is_equip(_char, _type, _tag){
	return false;
}