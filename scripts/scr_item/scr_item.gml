enum ITEMTYPE{
	HEAL,
	WEAPON,
	ARMOR,
	ACTION
}

function ItemData() constructor {
	heal = 0;
	atk = 0;
	def = 0;
	
	cost = 0;
	sell = 0;
	
	func = undefined;
	icon = undefined;
	
	name = {
		normal : "Undefined",
		short : "Undefined",
		battle : "Undefined",
	}
	desc = {
		area : "* Unknown.",
		battle : "Unknown.",
	}
	use_message = function() { return $"* Used {name.normal}!" };
}
