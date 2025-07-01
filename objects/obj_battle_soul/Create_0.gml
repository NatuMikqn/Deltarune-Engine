//does not work with circular boards
//modifying obj_battle_board.angle has no effect
//collision detection behaves unnaturally with diagonal borders when width and height differ
scale = new Vector2(1);
/////////////////////////////////

angle = 0;
alpha = 1;

collision_size = new Vector2(8, 8);

show = false;
hitbox = false;
movable = false;

target_hitbox = {
	hit : false,
	pos : [],
	ccw : false
}

board_update_hitbox()