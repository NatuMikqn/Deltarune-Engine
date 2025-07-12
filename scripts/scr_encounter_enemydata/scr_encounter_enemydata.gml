///@ignore
function Enemy() constructor
{
	object = undefined;
	
	name = "";
	hp = 0;
	maxhp = 0;
	atk = 0;
	def = 0;
	mercy = 0;
	mercyenable = true;
}

///敵情報を設定します
///@arg {String} tag
///@arg {Asset.GMObject} obj
function EnemyBuilder(_tag, _obj) : Enemy() constructor
{
	tag = _tag;
	object = _obj;
	
	///@arg {String} name
	///@return {Struct.EnemyBuilder}
	static set_name = function (_name) {
		name = _name;
		return self;
	}
	
	///@arg {Real} hp
	///@arg {Real} maxhp
	///@return {Struct.EnemyBuilder}
	static set_hp = function (_hp, _maxhp = _hp) {
		hp = _hp;
		maxhp = _maxhp;
		return self;
	}
	
	///@arg {Real} atk
	///@return {Struct.EnemyBuilder}
	static set_atk = function (_atk) {
		atk = _atk;
		return self;
	}
	
	///@arg {Real} def
	///@return {Struct.EnemyBuilder}
	static set_def = function (_def) {
		def = _def;
		return self;
	}
	
	///@arg {Real} check
	///@return {Struct.EnemyBuilder}
	static set_check = function (_check) {
		check = _check;
		return self;
	}
	
	///@arg {Any} any
	///@return {Struct.EnemyBuilder}
	static add_actlist = function (_any) {
		return self;
	}
	
	///@return {Struct.EnemyBuilder}
	static mercy_disable = function () {
		mercyenable = false;
		return self;
	}
	
	static build = function () {
		var _data = new EnemyData(self);
		global.enemy_data[$ tag] = _data;
	}
}

///@arg {Struct.EnemyBuilder} builder
///@ignore
function EnemyData(builder) : Enemy() constructor
{
	send_builder_to_data(builder);
	
	///@arg {Real} damage
	static damage = function (damage) {
		hp += damage;
		if (damage > 0){
			
		}else if (damage < 0){
			
		}
	}
	
	///@return {String}
	static get_name = function () { return name; }
	///@return {Real}
	static get_hp = function () { return hp; }
	///@return {Real}
	static get_maxhp = function () { return maxhp; }
	///@arg {Real} value
	static add_mercy = function (value) { return mercy + value; }
	///@return {Real}
	static get_mercy = function () { return mercy; }
}