//単色化 by NatuMikqn
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 tint;
uniform float power;

void main()
{
	vec4 color = texture2D(gm_BaseTexture, v_vTexcoord);
	
	gl_FragColor = v_vColour * vec4(mix(color.rgb, tint, power), color.a);
}
