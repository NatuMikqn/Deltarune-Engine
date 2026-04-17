//単色化 by NatuMikqn
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float time;
uniform float height;
uniform float period;

void main()
{
	vec2 vTex = v_vTexcoord;
	
	gl_FragColor = v_vColour * texture2D(gm_BaseTexture, vTex);
}
