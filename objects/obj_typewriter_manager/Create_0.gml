depth = - 999;

font_list = {};
anim_list = {
	create : {},
	step : {}
};

choice = {};
choicedata = noone;
choice_heartpos = new Vector2(-17, 18);
choice_changed = false;

default_font = "default";

typewriter_custom_font();
typewriter_custom_anim();

createid = -1;

choice_safedir = 0;

///@arg {Bool} is_vertical 捜索方向は垂直かどうか
///@arg {Bool} negamove 進行方向が負の値かどうか
///@arg {Bool} reverse リバースモードは有効か
function choice_search(_vertical, _negamove, _reverse)
{
	var _pos, _target = noone, _now = new Vector2(choicedata.x, choicedata.y), _next = infinity,
		_dirmax = choice_safedir, _dir, _dis, _rangeif, _tc = _vertical ? "y" : "x";
	if (_reverse) _next = 0;
	with (obj_typewriter_object){
		//対象のタイプライターオブジェクトは自身のではないか＆choiceは有効か
		if (id != other.choicedata && data.choice){
			_pos = new Vector2(x, y);
			//自身と対象との角度は適切であるかどうか
			//0基準にしている(20ならば-10~10)
			if (_dirmax == 0) _dir = point_direction(_now.x, _now.y, _pos.x, _pos.y) % 90;
			else _dir = abs((point_direction(_now.x, _now.y, _pos.x, _pos.y) + _dirmax / 2) % 90 - _dirmax / 2);
			//上か下かで探索範囲を変更する
			//逆であれば負の値が返される
			_dis = _pos[$_tc] - _now[$_tc];
			//移動方向が負の値かどうかとリバースモード時のXOR
			if (_negamove != _reverse) _dis *= -1;
			
			//リバースモード時は捜索範囲を逆転＆大きい数値をさがす
			if (_reverse) _rangeif = in_range_neq(_dis, _next, infinity);
			else _rangeif = in_range_neq(_dis, 0, _next);
			
			if (_rangeif && _dir <= _dirmax){
				_next = _dis;
				_dirmax = _dir;
				_target = id;
			}
		}
	}
	return _target;
}