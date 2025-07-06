///@ignore
function encounter_group_custom(){
	new EnemyGroupBuilder()
		.set_id(0)
		.add_enemy(480, 120, "testEnemy")
		.add_enemy(480, 240, "testEnemy")
		.set_music(-1)
		.set_dialog("[battle.test.dialog.encounter]")
		.build();
	
}