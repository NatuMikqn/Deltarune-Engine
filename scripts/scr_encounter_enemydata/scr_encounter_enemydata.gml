///@ignore
function Enemy() constructor
{
	object = undefined;
	
	name = "";
	hp = 0;
	maxhp = 0;
	atk = 0;
	def = 0;
	check = "";
	actlist = {};
}

///敵情報を設定します
///@arg {String} tag
///@arg {Asset.GMObject} obj
function EnemyBuilder(_tag, _obj) : Enemy() constructor
{
	tag = _tag;
	object = _obj;
	
	///@arg {Real} name
	///@return {Struct.EnemyBuilder}
	static set_name = function (_name) {
		name = _name;
		return self;
	}
	
	///@arg {Real} hp
	///@return {Struct.EnemyBuilder}
	static set_hp = function (_hp) {
		hp = _hp;
		maxhp = _hp;
		return self;
	}
	
	static build = function () {
		var _data = new EnemyData(self);
		global.enemy_data[$ tag] = _data;
	}
}

///@arg {Struct.EnemyBuilder} builder
///@ignore
function EnemyData(_builder) : Enemy() constructor
{
	send_builder_to_data(_builder);
	
	///@arg {Real} damage
	static damage = function (damage) {
		hp += damage;
		if (damage > 0){
			
		}else if (damage < 0){
			
		}
	}
	///@return {Real}
	static get_hp = function () { return hp; }
	///@return {Real}
	static get_maxhp = function () { return maxhp; }
}