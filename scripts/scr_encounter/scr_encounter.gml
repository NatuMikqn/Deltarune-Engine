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

///@arg {Struct.EnemyGroupData} 
function encounter_register(_egd){
	array_push(global.encount_group, _egd)
}


function EnemyGroup() constructor {
    id_ = -1;
    enemygroup = [];
    music = -1;
    dialog = "";
}

function EnemyGroupBuilder() : EnemyGroup() constructor {
    
    ///@arg {Real} id
    static set_id = function(_id){
        id_ = _id;
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
        var _egd = new EnemyGroupData(self);
        encounter_register(_egd);
    }
}

///@return {Struct.EnemyGroupBuilder}
function EnemyGroupData(_egb) : EnemyGroup() constructor {
    
    lists = variable_struct_get_names(_egb)
    array_foreach(lists, method({ self, _egb }, function(_e){
        self[$_e] = _egb[$_e];
    }))
    
    ///@return {Bool}
    ///@pure
    static equals_id = function(){
        return id_ == encounter_get_id();
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

///@arg {real} id
///@return {array}
function encounter_get(_id){
	return global.encount_group[_id];
}

///@arg {real} id
function encounter_set_id(_id){
	global.encount_id = _id;
}

///@return {real}
function encounter_get_id(){
	return global.encount_id;
}

///@arg {real} id
///@return {Asset.GMSound}
function encounter_get_mus(_id){
	return global.encount_data[_id].music;
}
///@arg {real} id
///@return {string}
function encounter_get_dialog(_id){
	return global.encount_data[_id].dialog;
}
function get_enemydata(){
    //array_any()
	return global.encount_data[_id].dialog;
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
    
    instance_create_depth(0, 0, 0, obj_encounter)
    
	/*
	encounter_set_id(_id)
	
	if (_set_tp) encounter_autoset_teampos();
	obj_char.movable = false;
	
	audio_play_sound(snd_tensionhorn, 0, 0, 1, 0);
	delay_create(function(){audio_play_sound(snd_tensionhorn, 0, 0, 1, 0, 1.1)}, "", true, 15);
	
	delay_create(method({_target, _id}, function(){
		
		var _team = team_get(),
			_obj
		for (var i=0;i<array_length(_team);i++){
			_obj = team_get_flag(_team[i], TEAMCHAR_FLAG.AREA_OBJ)
			team_set_flag(_team[i], TEAMCHAR_FLAG.ENCOUNTER_X, _obj.x)
			team_set_flag(_team[i], TEAMCHAR_FLAG.ENCOUNTER_Y, _obj.y)
		}

		obj_char_player.visible = false;
		if _target != noone _target.visible = false;
		
		var _i=instance_create_depth(0, 0, 0, obj_battle);
		_i.music = encounter_get_mus(_id)
		battle_set_dialog(encounter_get_dialog(_id))
		encounter_anim();
		
	}), "", true, 40);
    */
}

///@arg {real} id
function encounter_anim(){
	with(obj_battle_team){
		var _val = {
			id,
			x,
			y,
			char
		}
		easing_create(method(_val, function(_v){
			id.x = x + (team_get_flag(char, TEAMCHAR_FLAG.BATTLE_X, 0) - x) * _v
			id.y = y + (team_get_flag(char, TEAMCHAR_FLAG.BATTLE_Y, 0) - y) * _v
		}), "", false, [new EaseState(0, 0, 20)]);
		easing_create(method(_val, function(_v){
			if ((_v * 20) % 4 == 0){
				afterimage_create(id.x, id.y, id.depth + 1, id.sprite[id.sprite_anim], id.subimg, 2, 2).surface = battle_get_surface();
			}
		}), "", false, [new EaseState(0, 0, 20)]);
	}
}