//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform vec2 textureTexel;
uniform vec2 radius;
uniform vec4 color;
uniform float sampleCount;

const float PI = 3.1415926535;

void main()
{
	vec4 texc = texture2D(gm_BaseTexture, v_vTexcoord);
	
	float sum = 0.0;
	float alpha = 0.0;
	
	for(float i = 0.0; i < sampleCount; i++){
		float rad = 360.0 / sampleCount * i * PI / 180.0;
		vec2 nl = vec2(cos(rad), sin(rad));
		nl /= max(abs(nl.x), abs(nl.y));
		vec2 offset = nl * radius * textureTexel;
		
		vec4 temp = texture2D(gm_BaseTexture, v_vTexcoord + offset);
		alpha = max(alpha, temp.a);
	}
	
	float finalalpha = min(color.a + texc.a, 1.0);
	texc.rgb = mix(texc.rgb, color.rgb, alpha - texc.a);
	texc.a = min(texc.a + alpha, 1.0) * finalalpha;
	
	gl_FragColor = v_vColour * texc;
}
