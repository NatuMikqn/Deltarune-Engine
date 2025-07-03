enum TCANIM {
	CREATE,
	STEP
}

///@ignore
function typewriter_custom_anim()
{
	with(obj_typewriter_manager){
		
		//function (charData, [anything], ...)
		typewriter_add_anim(TCANIM.CREATE, "template", function (_chardata){
			with(_chardata){
				
				//anything here...
				
			}
		})
		
		//function (charData, createTrigger, [anything], ...)
		typewriter_add_anim(TCANIM.STEP, "template", function (_chardata, _once){
			with(_chardata){
				
				//anything here...
				
			}
		})
		
		typewriter_add_anim(TCANIM.CREATE, "test", function (_chardata){
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
		
		typewriter_add_anim(TCANIM.STEP, "shiftshake", function (_chardata, _once, _chance, _power){
			with(_chardata){
				if (_once){
					offset_user[0] = new Vector2();
				}
				if ((get_worldtimer() % 2) == 0){
					if (chance(5)){
						offset_user[0].set(irandom_range(-1, 1), irandom_range(-1, 1))
					}else{
						offset_user[0].set(0, 0)
					}
				}
			}
		})
		
	}
}