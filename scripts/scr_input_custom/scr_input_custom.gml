///@ignore
function input_custom(){
	input_type(INPUT_TYPE.KEYBOARD)
	
	input_config(INPUT.UP, vk_up)
	input_config(INPUT.DOWN, vk_down)
	input_config(INPUT.LEFT, vk_left)
	input_config(INPUT.RIGHT, vk_right)
	input_config(INPUT.CONFIRM, [ord("Z"), vk_enter])
	input_config(INPUT.CANCEL, [ord("X"), vk_shift])
	input_config(INPUT.MENU, [ord("C"), vk_control])
	
	input_type(INPUT_TYPE.GAMEPAD)
	
	input_config(INPUT.UP, ["up", gp_padu])
	input_config(INPUT.DOWN, ["down", gp_padd])
	input_config(INPUT.LEFT, ["left", gp_padl])
	input_config(INPUT.RIGHT, ["right", gp_padr])
	input_config(INPUT.CONFIRM, gp_face2)
	input_config(INPUT.CANCEL, gp_face1)
	input_config(INPUT.MENU, gp_start)
	
	input_endsetup()
	
	input_type(INPUT_TYPE.KEYBOARD)
}