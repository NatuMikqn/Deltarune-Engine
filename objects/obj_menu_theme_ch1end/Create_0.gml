event_inherited();

default_color = merge_color(c_ltgray, c_navy, 0.2);
select_color = c_white;
plus_color = merge_color(c_yellow, c_white, 0.5);

music = mus_saveselect;

anim_image = 0;

// 最初のスライド効果
bg_y = 0;
easing_run(id, "bg_y", 3, 1, 0, -40, 60);
