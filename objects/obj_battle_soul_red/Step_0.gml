var _spd = spd / (input_check(INPUT.CANCEL) + 1)
var _pos = new Vector2();

if (movable){
	hsp = input_check(INPUT.RIGHT) - input_check(INPUT.LEFT);
	vsp = input_check(INPUT.DOWN) - input_check(INPUT.UP);
}

x += hsp * _spd;
y += vsp * _spd;