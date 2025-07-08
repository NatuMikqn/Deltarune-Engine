///@arg {real} value
function battle_get_charicon(_value){
	switch (_value) {
		case BATTLE_CHAR_ACTION.FIGHT: return 1;
		case BATTLE_CHAR_ACTION.ACT: return 2;
		case BATTLE_CHAR_ACTION.ITEM: return 3;
		case BATTLE_CHAR_ACTION.SPARE: return 10;
		case BATTLE_CHAR_ACTION.DEFEND: return 4;
	}
}