///カスタムダイアログ
function battle_custom_dialog()
{
	var _sl = battle_get_buttonselect(battle_get_charturn());
	var _buttontype = battle_get_buttondata(_sl).get_type();
	with (obj_battle){
		if (_buttontype == BUTTON_TYPE.FIGHT){
			battle_set_dialog_message(DIALOG_UI.SELECTENEMY)
			//battle_next_char(1)
		}else
		if (_buttontype == BUTTON_TYPE.ACT){
			battle_set_dialog_message(DIALOG_UI.SELECTENEMY)
			//battle_next_char(2)
		}else
		if (_buttontype == BUTTON_TYPE.ITEM){
			battle_set_dialog_message(DIALOG_UI.LIST)
			//battle_next_char(3)
		}else
		if (_buttontype == BUTTON_TYPE.SPARE){
			battle_set_dialog_message(DIALOG_UI.SELECTENEMY)
			battle_set_dialog_next(0)
			//battle_next_char(10)
		}else
		if (_buttontype == BUTTON_TYPE.DEFEND){
			battle_team_set_anim(battle_char_ids[charturn], BATTLE_TEAM_ANIM.DEFEND, BATTLE_ANIM_LOOP.ONLY)
			battle_next_char(4, 16)
		}
	}
}