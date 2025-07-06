enum BUTTON_TYPE
{
	FIGHT,
	ACT,
	ITEM,
	SPARE,
	DEFEND
}

///@ignore
function team_custom_buttongroup()
{
	team_buttongroup_register("defaultKris", [
		"fight", "act", "item", "spare", "defend"
	])
	
	team_buttongroup_register("defaultMons", [
		"fight", "tech", "item", "spare", "defend"
	])
	
	team_buttongroup_register("noDefend", [
		"fight", "act", "item", "spare"
	])
	
	team_buttongroup_register("noDefendTech", [
		"fight", "tech", "item", "spare", "defend"
	])
}

///@ignore
function team_custom_button()
{
	team_button_register("fight", new ButtonInfo(BUTTON_TYPE.FIGHT, "battle.button.fight", function () {
		battle_dialog_enemyselect(function () {
			battle_dialog_list()
		})
	}));
	team_button_register("act", new ButtonInfo(BUTTON_TYPE.ACT, "battle.button.act", function () {
		battle_dialog_enemyselect(function () {
			battle_dialog_list()
		})
	}));
	team_button_register("tech", new ButtonInfo(BUTTON_TYPE.ACT, "battle.button.tech", function () {
		battle_dialog_enemyselect(function () {
			battle_dialog_list()
		})
	}));
	team_button_register("item", new ButtonInfo(BUTTON_TYPE.ITEM, "battle.button.item", function () {
		battle_dialog_list()
	}));
	team_button_register("spare", new ButtonInfo(BUTTON_TYPE.SPARE, "battle.button.spare", function () {
		battle_dialog_enemyselect(function () {
			//battle_team_set_anim(battle_char_ids[charturn], BATTLE_TEAM_ANIM.DEFEND, BATTLE_ANIM_LOOP.ONLY)
			battle_next_char(4, 16)
		})
	}));
	team_button_register("defend", new ButtonInfo(BUTTON_TYPE.DEFEND, "battle.button.defend", function () {
		battle_team_set_anim(battle_char_ids[charturn], BATTLE_TEAM_ANIM.DEFEND, BATTLE_ANIM_LOOP.ONLY)
		battle_next_char(4, 16)
	}));
}