//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	vec4 texc = texture2D(gm_BaseTexture, v_vTexcoord);
	vec3 bg = vec3(0.0, 1.0, 0.0);
	
	texc.rgb = mix(bg, texc.rgb, texc.a);
	texc.a = 1.0;
	
	gl_FragColor = v_vColour * texc;
}
