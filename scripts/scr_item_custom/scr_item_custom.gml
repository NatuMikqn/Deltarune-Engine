enum ITEM{
    VSHP,
    NOODLES
}


//TODO: Overhaul it

function item_custom(){
	var _db = item_get_database(),
	    _i;

	#region VS-HealPotion

	_i = new ItemData()

	_i	.set_name("Very Super Healing Potion").set_name_battle("VS-HealPotion")
		.set_desc("* AAAAAAAAAAA").set_desc_battle("mazusou")
		.set_component(ITEM_COMPONENT.HEAL).set_heal(24)
		.set_use_message("* umazui.")

	_db.register(ITEM.VSHP, _i)

	#endregion

	#region InstaNood

	_i = new ItemData()
	_i	.set_name("Instant Noodles").set_name_short("InstaNood").set_name_battle("I. Noodles")
		.set_desc("* Noodles")
		.set_component(ITEM_COMPONENT.HEAL).set_heal(1)
		.set_use_func(function(){
		    if (in_battle() && encounter_get_id() == 0){
		        dialog_set("<heal 90>* un! oisii")
		    }else{
		        bgm_pause(0)
		        dialog_set("<* true>* ...<pause><clear>...<pause><clear>...<pause><clear><bgm_resume 0><heal 1>* mazui")
		    }
		})

	_db.register(ITEM.NOODLES, _i)

	#endregion
}