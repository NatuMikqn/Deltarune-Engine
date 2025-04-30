
function ItemDB() constructor{
	data = [];
	static register = function(_id, _data){
		data[_id] = _data
	}
	static remove = function(_id){
		delete data[_id]
	}
}

function ItemData() constructor{
	
	name = "";
	name_short = "";
	name_battle = "";
	desc = "";
	desc_battle = "";
	component = undefined;
	use_message = "";
	use_template = "";
	heal = 0;
	atk = 0;
	def = 0;
	func = undefined;
	
	///@arg {string} name
	static set_name				= function(_val){ name = _val }
	///@arg {string} name
	static set_name_short		= function(_val){ name_short = _val }
	///@arg {string} name
	static set_name_battle		= function(_val){ name_battle = _val }
	///@arg {string} desc
	static set_desc				= function(_val){ desc = _val }
	///@arg {string} desc
	static set_desc_battle		= function(_val){ desc_battle = _val }
	///@arg {real} component
	static set_component		= function(_val){ component = _val }
	///@arg {string} message
	static set_use_message		= function(_val){ use_message = _val }
	///@arg {bool} enable
	static set_use_template		= function(_val){ use_template = _val }
	///@arg {real} heal
	static set_heal				= function(_val){ heal = _val }
	///@arg {real} atk
	static set_atk				= function(_val){ atk = _val }
	///@arg {real} def
	static set_def				= function(_val){ def = _val }
	///@arg {function} function
	static set_use_func			= function(_val){ func = _val }
}

function item_init(){
	global.item_db = new ItemDB();
	
	item_custom();
}

function item_get_database(){
	return global.item_db;
	
}
