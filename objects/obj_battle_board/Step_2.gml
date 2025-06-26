//board collisions

var _a, _b, _c, _scale, _ang, _len, _data;

_len = array_length(original_list);

if (scale > 0 && _len){
	list = variable_clone(original_list);
	//それぞれの枠に回転等を設定します
	for (var i = 0; i < _len; i++) {
		if (scale > 0 && _len){
			_data = list[i];
			
			_ang = angle;
			_scale = new Vector2(scale);
			
			//ポリゴン
			if (_data.type == BOARD_TYPE.POLYGON){
				for (var j = 0; j < array_length(_data.polydata); j++) {
					
					_a = _data.polydata[j].mul(_scale);
					_b = _data.polyoffset[j].mul(_scale);
					_c = _data.polyhitbox[j].mul(_scale);
					
					if (_ang % 360 != 0){
						_a.rot(_ang);
						_b.rot(_ang);
						_c.rot(_ang);
					}
				}
			}
			//円
			else if (_data.type == BOARD_TYPE.CIRCLE){
				_data.scale *= _scale.x;
			}
			
		}
	}
}

//ソウル判定
with (obj_battle_soul) event_user(0)

//フェードアウト
for(var i=0;i<array_length(afterimage_list);i++){
	afterimage_list[i].step()
	if (afterimage_list[i].fadeout < 0){
		array_delete(afterimage_list, i, 1)
		i--
	}
}

//残像
if (afterimage){
	if (easing_exists("board_anim")){
		if (timer % 2 == 0){
			_len = array_length(list)
			for (var i = 0; i < _len; i++) {
				array_push(afterimage_list, new CreateAfterImage(list[i], 1 - alpha + 0.1))
			}
		}
	}
	//枠が回転中でなければafterimageを停止する
	else{
		afterimage = false;
	}
}
timer++