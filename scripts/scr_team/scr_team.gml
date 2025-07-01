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
	TECHABLE,
	
	ENCOUNTER_X,
	ENCOUNTER_Y,
	BATTLE_X,
	BATTLE_Y
}

function team_init()
{
	global.char_data = {};
	global.team_list = [];
}

///@ignore
function CharacterInfo() constructor
{
	id = "";
	hp = 100;
	maxhp = 100;
	color = c_orange;
	object = {
		arena : obj_char_player,
		battle : obj_battle_team_kris
	}
	techable = true;
	
	pos = {
		encount : new Vector2(),
		battle : new Vector2(),
	}
	charbox_info = {
		icon : spr_missing,
		name : spr_missing
	}
}

///@arg {String} id
function CharacterInfoBuilder(_id) : CharacterInfo() constructor
{
	id = _id;
	
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
	///@arg {Bool} techable
	static set_techable = function(_val){
		techable = _val;
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
		global.char_data[$id] = _data;
	}
}

///@ignore
///@arg {Struct.CharacterInfoBuilder} teaminfo
function CharacterInfoData(_self) : CharacterInfo() constructor
{
	var _lists = variable_struct_get_names(self);
	
	array_foreach(_lists, method(_self, function(_e){
		other[$_e] = self[$_e];
	}))
	
	static get_hp = function(){ return hp; }
	static get_maxhp = function(){ return maxhp; }
	static get_color = function(){ return color; }
	static get_obj_arena = function(){ return object.arena; }
	static get_obj_battle = function(){ return object.battle; }
	static is_techable = function(){ return techable; }
	static get_charbox_iconsprite = function()
	{
		var _spr = charbox_info.icon;
		if (is_string(_spr)) _spr = get_sprite(_spr);
		return _spr;
	}
	static get_charbox_namesprite = function()
	{
		var _spr = charbox_info.name;
		if (is_string(_spr)) _spr = get_sprite(_spr);
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