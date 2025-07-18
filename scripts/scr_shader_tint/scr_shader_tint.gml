function shader_apply_tint(_color, _power)
{
	static uniform = {
		color : shader_get_uniform(shd_tint, "tint"),
		power : shader_get_uniform(shd_tint, "power")
	}
	
	shader_set(shd_tint);
	var _rgb = col2list(_color);
	shader_set_uniform_f_array(uniform.color, _rgb);
	shader_set_uniform_f(uniform.power, _power);
}