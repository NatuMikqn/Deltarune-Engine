event_inherited();

draw_set_color(c_teal);
draw_circle(x, y, encounter_circle_hitbox, true)

draw_set_color(c_white);
draw_set_color(c_green);

var hitbox_center = new Vector2(x, y - hitbox_size.y / 2);
draw_rectangle(
	hitbox_center.x - hitbox_size.x / 2,
	hitbox_center.y - hitbox_size.y / 2,
	hitbox_center.x + hitbox_size.x / 2,
	hitbox_center.y + hitbox_size.y / 2,
	true);

draw_set_color(c_red);

var interaction_center = new Vector2(interaction_offset.x + x, interaction_offset.y + y);
draw_rectangle(
	interaction_center.x - interaction_size.x / 2,
	interaction_center.y - interaction_size.y / 2,
	interaction_center.x + interaction_size.x / 2,
	interaction_center.y + interaction_size.y / 2,
	true);



draw_set_color(c_white);