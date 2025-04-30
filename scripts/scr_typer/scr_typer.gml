///@arg {real} x
///@arg {real} y
///@arg {string} text
function typer_create(_x, _y, _text){
	var _typer = instance_create_depth(_x, _y, 0, obj_typer);
	_typer.text = _text;
	if (instance_exists(obj_battle)){
		_typer.battle_surface = true;
	}
	return _typer;
}

///@arg {real} x
///@arg {real} y
///@arg {string} text
///@arg {real} choice
///@arg {function} function
function choice_create(_x, _y, _text, _choice, _func){
	var _typer = typer_create(_x, _y, _text)
	_typer.choice = _choice;
	_typer.func = _func;
}