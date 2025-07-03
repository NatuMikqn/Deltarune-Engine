enum TCANIM {
	CREATE,
	STEP
}

///@ignore
function typewriter_custom_anim()
{
	with(obj_typewriter_manager){
		
		typewriter_add_anim(TCANIM.CREATE, "template", function (_chardata){
			with(_chardata){
				
				//anything here...
				
			}
		})
		
		typewriter_add_anim(TCANIM.CREATE, "test", function (_chardata){
			with(_chardata){
				
				var _rand = [1 - irandom(1) * 2, 1 - irandom(1) * 2]
				var _eb = new EasingBuilder(method({char: _chardata, _rand}, function (_v) {
					char.offset.x = _v * _rand[0];
					char.offset.y = _v * _rand[1];
				}))
				_eb.start(12).add_step(3, 1, 60, 0).set_target(true).build();
				
				_eb = new EasingBuilder(method(_chardata, function (_v) {
					alpha = _v;
				}))
				_eb.start(0.5).add_step(0, 1, 20, 1).set_target(true).build();
				
			}
			
		})
		
		typewriter_add_anim(TCANIM.STEP, "shake", function (_chardata){
			with(_chardata){
				
				if (chance(5)){
					
				}
				
			}
		})
		
	}
}