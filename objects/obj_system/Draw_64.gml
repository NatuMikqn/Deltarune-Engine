draw_set_font(fnt_8bit)
draw_set_ca()
var _dbg = ""
_dbg += $"room: {room_get_name(room)}\n"
_dbg += $"camera: {obj_camera.x}, {obj_camera.y}\n"
if instance_exists(obj_battle){
	_dbg += $"state: {obj_battle.state}\n"
	_dbg += $"nextState: {obj_battle.next_state}\n"
	_dbg += $"nextStateTimer: {obj_battle.next_state_timer}\n"
}
draw_text(4, 4, _dbg)
draw_set_color(c_white)

//draw_sprite(spr_battle_button_act, 0, 20 + aaa * 240, 120)