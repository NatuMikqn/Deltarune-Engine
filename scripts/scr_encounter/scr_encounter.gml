function encounter_init(){
	global.encount_group = [];
	global.encount_data = [];
	global.encount_id = -1;
}

///@arg {real} x
///@arg {real} y
///@arg {Asset.GMObject} obj
///@arg {real} depth
function EnemyData(_x, _y, _obj, _depth = undefined) constructor{
	x = _x;
	y = _y;
	object = _obj;
	depth = _depth ?? -_y;
}

///@desc 敵グループ情報を登録
///@arg {Struct.EnemyGroupData} 
function encounter_register(_egd){
	array_push(global.encount_group, _egd)
}

///@ignore
function EnemyGroup() constructor {
	id = -1;
	enemygroup = [];
	music = -1;
	dialog = "";
}

///敵グループを作成するための関数
function EnemyGroupBuilder() : EnemyGroup() constructor {
	
	///@arg {Real} id
	static set_id = function(_id){
		id = _id;
		return self;
	}
	
	///@arg {Struct.EnemyData} enemyData
	static add_enemy = function(_enemy){
		array_push(enemygroup, _enemy);
		return self;
	}
	
	///@arg {Asset.GMSound} music
	static set_music = function(_music){
		music = _music;
		return self;
	}
	
	///@arg {String} dialog
	static set_dialog = function(_dialog){
		dialog = _dialog;
		return self;
	}
	
	static build = function(){
		encounter_register(new EnemyGroupData(self));
	}
}

///@ignore
///@return {Struct.EnemyGroupBuilder}
function EnemyGroupData(_egb) : EnemyGroup() constructor {
	
	var _lists = variable_struct_get_names(self);
	
	array_foreach(_lists, method(_egb, function(_e){
		other[$_e] = self[$_e];
	}))
	
	///@arg {real} id
	///@return {Bool}
	///@pure
	static equals_id = function(_id = encounter_get_id()){
		return id == _id;
	}
	
	///@return {Asset.GMSound}
	static get_music = function(){
		return music;
	}
	
	///@return {Array<Struct.EnemyData>}
	static get_enemy = function(){
		return enemygroup;
	}
	
	///@arg {String} dialog
	static get_dialog = function(){
		return dialog;
	}
}

///@desc 敵IDを設定
///@arg {real} id
function encounter_set_id(_id){
	global.encount_id = _id;
}

///@desc 現在指定されている敵IDを取得
///@return {real}
///@pure
function encounter_get_id(){
	return global.encount_id;
}

///現在指定されている敵IDからデータを取得します
///直接idを指定することもできます
///@arg {real} id
///@return {Struct.EnemyGroupData}
///@pure
function get_enemydata(_id = encounter_get_id()){
	return encounter_get(_id);
}

///現在指定中の敵グループIDが有効な物かどうか
///@arg {real} id
///@return {Bool}
///@pure
function check_enemyid(_id = encounter_get_id()){
	return encounter_getindex(_id) != -1;
}

///@desc 敵グループ情報がある位置を取得
///@arg {real} id
///@return {real}
///@pure
function encounter_getindex(_id){
	var _index = array_find_index(global.encount_group, method({ _id }, function(_e){
		return _e.equals_id(_id);
	}));
	return _index;
}

///@desc 敵グループ情報を取得
///@arg {real} id
///@return {Struct.EnemyGroupData}
///@pure
function encounter_get(_id){
	var _index = encounter_getindex(_id);
	if (_index == -1) throw $"invalid ID (ID → {_id})";
	
	return global.encount_group[_index];
}

function encounter_autoset_teampos(){
	var _team = team_get(),
		_count = team_get_count()
	for (var i=0;i<_count;i++){
		team_set_flag(_team[i], TEAMCHAR_FLAG.BATTLE_X, 100)
		if (_count == 1){
			team_set_flag(_team[i], TEAMCHAR_FLAG.BATTLE_Y, 216)
		}else if (_count == 2){
			team_set_flag(_team[i], TEAMCHAR_FLAG.BATTLE_Y, 216 - 40 + i*100)
		}else{
			team_set_flag(_team[i], TEAMCHAR_FLAG.BATTLE_Y, 216 - 90 + i*(180/(_count-1)))
		}
	}
}

///@arg {real} id
///@arg {Id.Instance} target_enemy
///@arg {bool} autoset_teampos
function encounter_start(_id = encounter_get_id(), _target = noone, _set_tp = true){
	encounter_set_id(_id)
	
	if (_set_tp) encounter_autoset_teampos();
	obj_char.movable = false;
	
	var _inst = instance_create_depth(0, 0, 0, obj_encounter)
	_inst.enemy_target = _target;
	
}