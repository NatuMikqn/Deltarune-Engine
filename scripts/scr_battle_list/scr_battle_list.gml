///戦闘用リスト作成
///@arg {String} label
function BattleDialogList(_label, _desc, _nextfunc = undefined) constructor {
	label = _label;
	desc = _desc;
	nextfunc = _nextfunc;
	
	///@return {String}
	function get_label(){ return label }
	///@return {String}
	function get_desc(){ return desc }
	///@return {Function}
	function get_func(){ return nextfunc }
}