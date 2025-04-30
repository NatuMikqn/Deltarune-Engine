if (sprite_loop != BATTLE_ANIM_LOOP.NONE) animtime++

var _sprite = sprite[sprite_anim]

if (sprite_loop != BATTLE_ANIM_LOOP.NONE)	subimg = floor(animtime / animspd)
else										subimg = animtime

if (sprite_loop == BATTLE_ANIM_LOOP.ONLY)	subimg = min(subimg, sprite_get_number(_sprite) - 1)
else
if (sprite_loop == BATTLE_ANIM_LOOP.LOOP)	subimg = subimg % sprite_get_number(_sprite)