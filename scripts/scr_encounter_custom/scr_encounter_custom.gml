///@ignore
function encounter_group_custom(){
	new EnemyGroupBuilder()
		.set_id(0)
		.add_enemy(480, 120, "testEnemy1")
		.add_enemy(480, 240, "testEnemy2")
		.add_enemy(480, 240, "testEnemy3")
		.add_enemy(480, 240, "testEnemy2")
		.add_enemy(480, 240, "testEnemy3")
		.add_enemy(480, 240, "testEnemy1")
		.add_enemy(480, 240, "testEnemy3")
		.set_dialog("[battle.test.dialog.encounter]")
		.build();
	
}