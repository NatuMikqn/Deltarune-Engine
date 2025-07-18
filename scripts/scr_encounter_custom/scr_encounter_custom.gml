///@ignore
function encounter_group_custom()
{
	var _egb = new EnemyGroupBuilder()
		.set_id(0)
		.set_dialog("[battle.test.dialog.encounter]");
	var _count = irandom(12);
	
	repeat (_count) {
		_egb.add_enemy(480, irandom(360), $"testEnemy{irandom(2) + 1}")
	}
	
	_egb.build()
	
}