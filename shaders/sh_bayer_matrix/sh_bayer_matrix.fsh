//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

const mat4 bayer = mat4(0.0, 8.0, 2.0, 10.0,
						12.0, 4.0, 14.0, 6.0,
						3.0, 11.0, 1.0, 9.0,
						15.0, 7.0, 13.0, 5.0
						);

void main()
{
	vec4 col = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	
	ivec2 bayerCoord = ivec2(mod(gl_FragCoord, 4.0));
	float threshold = bayer[bayerCoord.x][bayerCoord.y];
	
	col.a = step((1. + threshold), col.a * 17.);
	
    gl_FragColor = col;
}
