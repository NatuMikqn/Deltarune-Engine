enum ITEM_COMPONENT{
	NONE,
	HEAL,
	WEAPON,
	ARMOR,
	ACCESSORY
}

///@arg {Struct.ItemData} data
///@arg {real} type
function item_apply_component(_data, _type){
	with(_data){
		array_push(component, _type)
		switch (_type){
			case ITEM_COMPONENT.HEAL:
				heal = 0;
				break;
			case ITEM_COMPONENT.WEAPON:
				damage = 0;
				break;
			case ITEM_COMPONENT.ARMOR:
				armor = 0;
				break;
		}
	}
}

///@arg {Struct.ItemData} data
///@arg {string} desc
function item_set_name(_data, _name){
	_data.desc = _desc;
}
///@arg {Struct.ItemData} data
///@arg {string} desc
function item_set_desc(_data, _desc){
	_data.desc = _desc;
}
///@arg {Struct.ItemData} data
///@arg {real} heal
function item_set_heal(_data, _heal){
	_data.heal = _heal;
}
///@arg {Struct.ItemData} data
///@arg {real} heal
function item_set_damage(_data, _damage){
	_data.damage = _damage;
}