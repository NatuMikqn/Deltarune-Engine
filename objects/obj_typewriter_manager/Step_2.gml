var _inputcheck = [
	input_check_pressed(INPUT.UP),
	input_check_pressed(INPUT.DOWN),
	input_check_pressed(INPUT.LEFT),
	input_check_pressed(INPUT.RIGHT),
]

if (instance_exists(choicedata)){
	var _target = noone;
	//上下キーのどっちかが押された場合
	if (_inputcheck[0] || _inputcheck[1]){
		_target = choice_search(true, _inputcheck[0], false);
		//見つからなければ逆から探す
		if (_target == noone){
			_target = choice_search(true, _inputcheck[0], true);
		}
		if (_target != noone) choicedata = _target;
	}
	//左右キーのどちらかが押された場合
	if (_inputcheck[2] || _inputcheck[3]){
		_target = choice_search(false, _inputcheck[2], false);
		//見つからなければ逆から探す
		if (_target == noone){
			_target = choice_search(false, _inputcheck[2], true);
		}
		if (_target != noone) choicedata = _target;
	}
}