function BattleActionSusieBuster() : BattleCharAct() constructor
{
	action_timer = 0;
	action_step = 0;
	
	///@arg {Id.Instance} actor actor InstID
	///@arg {Id.Instance} target target InstID
	static step = function(_actor, _target) {
		if (action_timer == 0) {
			switch (action_step) {
				case 0:
					action_timer = 60;
					battle_team_set_anim(_actor, spr_battle_button_act, false, 1);
					break;
				case 1:
					action_timer = 20;
					
					break;
				case 2:
					
					battle_act_end();
					return;
			}
			action_step ++;
		}
		action_timer --;
	}
}