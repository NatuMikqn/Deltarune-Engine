depth = DEPTH.CHAR
timer = 0

anim_img = 0;
anim_speed = 0.1;
// 条件関係無く常にアニメーションをさせるかどうか
anim_always = false;

/// @arg {Bool} or_conditions 他の条件
function anim_process(_or = false) {
	if (anim_always || _or) {
		anim_img += anim_speed;
	}
}

function anim_reset() {
	if (!anim_always && anim_img != 0) anim_img = 0;
}