varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 textureTexel;
uniform float radius;
uniform float bloom;
uniform bool vertical;

const float PI = 3.1415926535;

float gaussian(float x) {
	float sigma = radius * 0.5;
	return exp(-0.5 * pow(x, 2.0) / pow(sigma, 2.0)) / (sqrt(2.0 * PI) * sigma);
}

void main()
{
	vec4 texc = vec4(0.0, 0.0, 0.0, 0.0);
	
	float sum = 0.0;
	
	if (radius > 0.0){
		if (bloom < 0.1){
			texc = vec4(v_vTexcoord.x, v_vTexcoord.y, 0.0, 1.0);
		}else{
			for(float i=0.0; i<radius * 2.0 + 1.0; i+=bloom){
				float weight = gaussian(i - radius);
				vec2 offset = vec2(vertical ? 0.0 : (i - radius), vertical ? (i - radius) : 0.0) * textureTexel;
				texc += texture2D(gm_BaseTexture, v_vTexcoord + offset) * weight;
				sum += weight;
			}
			texc /= sum;
		}
	}else{
		texc = texture2D(gm_BaseTexture, v_vTexcoord);
	}
	
	gl_FragColor = v_vColour * texc;
}

uniform sampler2D baseTexture;