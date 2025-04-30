function encounter_group(){
	new EnemyGroupBuilder()
        .set_id(0)
        .add_enemy(new EnemyData(480, 120, obj_battle_enemy_test))
        .add_enemy(new EnemyData(480, 240, obj_battle_enemy_test))
        .set_music(mus_bigshot)
        .set_dialog("test.dialog.encounter")
        .build();
    
}