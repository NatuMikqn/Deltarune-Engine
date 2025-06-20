

function board_update(){
	with (obj_battle_board){
		polygons_offset.main = offset_point_jtmiter(polygons.main, 5);
	}
	
}