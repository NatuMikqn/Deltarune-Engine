///@ignore
function enemy_custom(){
	new EnemyBuilder("testEnemy1", obj_battle_enemy_test)
		.set_name("<color yellow>test")
		.set_hp(160).build();
	new EnemyBuilder("testEnemy2", obj_battle_enemy_test)
		.set_name("<color cblue>TEST ENEMY!!!!!!")
		.set_hp(20, 999).build();
	new EnemyBuilder("testEnemy3", obj_battle_enemy_test)
		.set_name("<color mixst>SUPER ENEMY")
		.set_hp(48000, 96000).build();
	
	
}