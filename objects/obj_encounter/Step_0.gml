timer--;
if (timer == 0){
	if (step == 0){
		audio_play_sound(snd_tensionhorn, 0, 0, 1, 0);
		
		timer = 15
		step++;
	}
	else if (step == 1){
		audio_play_sound(snd_tensionhorn, 0, 0, 1, 0, 1.1)
		
		timer = 25
		step++;
	}
	else if (step == 2){
		
		//チームの配置位置を指定
		var _team = team_get(),
			_obj
		//エンカウント開始位置を記憶
		for (var i=0;i<array_length(_team);i++){
			_obj = _team[i].get_obj_arena()
			_team[i].set_position_encounter(_obj.x, _obj.y)
		}
	 
		obj_char_player.visible = false; 
		
		if enemy_target != noone enemy_target.visible = false;
		
		var _data = get_enemydata();
		
		var _i=instance_create_depth(0, 0, 0, obj_battle);
		_i.music = _data.get_music();
		battle_set_dialog(_data.get_dialog());
		event_user(0)		//anim
		
		timer = 20;
		step++;
	}
	//background fadein
	else if (step == 3){
		new EasingBuilder(function (_v) {
					//obj_battle.background_alpha = _v;
				})
				.add_step(EASING_TWEEN.LINEAR, EASING_EASE.IN, 20, 1)
				.build();
		
		audio_play_sound(snd_impact, 0, 0, 0.7)
		audio_play_sound(snd_weaponpull_fast, 0, 0, 0.8)
		
		with(obj_battle_team) battle_team_set_anim(id, BATTLE_TEAM_ANIM.SETUP, BATTLE_ANIM_LOOP.ONLY)
		
		timer = 28
		step++;
	}
	//startbattle
	else if (step == 4){
		
		with(obj_battle_ui) event_user(0)
		with(obj_battle_team) battle_team_set_anim(id, BATTLE_TEAM_ANIM.IDLE, BATTLE_ANIM_LOOP.LOOP, 10)
		
		battle_set_state(BATTLE_STATE.MYTURN)
		
		bgm_play(1, obj_battle.music)
	}
}