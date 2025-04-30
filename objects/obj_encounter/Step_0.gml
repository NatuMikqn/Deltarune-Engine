timer--;
if (timer == 0){
    if (step == 0){
        audio_play_sound(snd_tensionhorn, 0, 0, 1, 0, 1.1)
        
        timer = 40
        step = 1;
    }
    if (step == 1){
        
        //チームの配置位置を指定
        var _team = team_get(),
    		_obj
    	for (var i=0;i<array_length(_team);i++){
    		_obj = team_get_flag(_team[i], TEAMCHAR_FLAG.AREA_OBJ)
    		team_set_flag(_team[i], TEAMCHAR_FLAG.ENCOUNTER_X, _obj.x)
    		team_set_flag(_team[i], TEAMCHAR_FLAG.ENCOUNTER_Y, _obj.y)
    	}
     
    	obj_char_player.visible = false;
    	if _target != noone _target.visible = false;
    	
        var _data = get_enemydata();
        
    	var _i=instance_create_depth(0, 0, 0, obj_battle);
    	_i.music = encounter_get_mus(_id)
    	battle_set_dialog(encounter_get_dialog(_id))
    	encounter_anim();
           
        timer = 30
        step = 2;
    }
    
}