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
	team_buttongroup_register("defaultKris", [ "fight", "act", "item", "spare", "defend" ])
	
	team_buttongroup_register("defaultMons", [ "fight", "tech", "item", "spare", "defend" ])
	
	team_buttongroup_register("noDefend", [ "fight", "act", "item", "spare" ])
	
	team_buttongroup_register("noDefendTech", [ "fight", "tech", "item", "spare", "defend" ])
}

///@ignore
function team_custom_button()
{
	team_button_register("fight", new ButtonInfo(BUTTON_TYPE.FIGHT, "battle.button.fight"));
	team_button_register("act", new ButtonInfo(BUTTON_TYPE.ACT, "battle.button.act"));
	team_button_register("tech", new ButtonInfo(BUTTON_TYPE.ACT, "battle.button.tech"));
	team_button_register("item", new ButtonInfo(BUTTON_TYPE.ITEM, "battle.button.item"));
	team_button_register("spare", new ButtonInfo(BUTTON_TYPE.SPARE, "battle.button.spare"));
	team_button_register("defend", new ButtonInfo(BUTTON_TYPE.DEFEND, "battle.button.defend"));
}