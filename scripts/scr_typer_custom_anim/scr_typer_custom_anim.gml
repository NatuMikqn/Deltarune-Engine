enum TCANIM {
	CREATE,
	STEP
}

///@ignore
function typewriter_custom_anim()
{
	with(obj_typewriter_manager){
		
		/*
		//function (charData, [anything], ...)
		typewriter_add_animcreate("template", function (_chardata){
			with(_chardata){
				
				//create function
				//anything here...
				
			}
		})
		
		
		//function (charData, createTrigger, [anything], ...)
		typewriter_add_animstep("template", function (_chardata, _once){
			with(_chardata){
				
				//step function
				//anything here...
				
			}
		}, function (_chardata){
			with(_chardata){
				
				//cleanup function
				//anything here...
				
			}
		})
		*/
		
		typewriter_add_animcreate("test", function (_chardata){
			with(_chardata){
				
				var _rand = [1 - irandom(1) * 2, 1 - irandom(1) * 2]
				var _eb = new EasingBuilder(method({char: _chardata, _rand}, function (_v) {
					char.set_offset(_v * _rand[0], _v * _rand[1]);
				}))
				_eb.start(12).add_step(3, 1, 60, 0).set_target(true).build();
				
				_eb = new EasingBuilder(method(_chardata, function (_v) {
					alpha = _v;
				}))
				_eb.start(0.5).add_step(0, 1, 20, 1).set_target(true).build();
				
			}
			
		})
		
		typewriter_add_animstep("shake", function (_chardata, _once, _power = 1, _chance = 1){
			with(_chardata){
				if (_once){
					//カスタムオフセット値の登録
					offset_user.shake = new Vector2();
				}
				
				if ((get_worldtimer() % 2) == 0){
					if (chance(_chance)){
						offset_user.shake.set(irandom_range(-_power, _power), irandom_range(-_power, _power))
					}else{
						offset_user.shake.set(0, 0)
					}
				}
			}
		}, function (_chardata){
			with(_chardata){
				//アニメーション終了時、カスタムオフセット値を0に戻す
				if (struct_exists(offset_user, "shake")) offset_user.shake.zero();
			}
		})
		
		typewriter_add_animstep("circle", function (_chardata, _once, _xlen = 2, _ylen = 2, _xspd = 2, _yspd = 2){
			with(_chardata){
				if (_once){
					//カスタムオフセット値の登録
					offset_user.circle = new Vector2();
				}
				if ((get_worldtimer() % 2) == 0){
					offset_user.circle.x = lengthdir_x(_xlen, get_chartimer() * _xspd);
					offset_user.circle.y = lengthdir_y(_ylen, get_chartimer() * _yspd);
				}
			}
		}, function (_chardata){
			with(_chardata){
				//アニメーション終了時、カスタムオフセット値を0に戻す
				if (struct_exists(offset_user, "circle")) offset_user.circle.zero();
			}
		})
		
	}
}