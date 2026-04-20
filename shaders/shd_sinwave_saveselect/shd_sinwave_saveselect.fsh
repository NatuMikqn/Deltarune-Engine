// SinWave by NatuMikqn
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float time;
uniform float ystart;
uniform float period;
uniform float power;
uniform vec2 texelSize;

const float PI = 3.14159265359;

float dsin(float value)
{
	return sin(value * PI / 180.0);
}

void main()
{
	vec2 vTex = v_vTexcoord;
	vec2 imageSize = 1.0 / texelSize;
	float yTex = ystart - v_vTexcoord.y * imageSize.y;
	float wave = yTex * texelSize.y;
	
	if (wave > 0.0) {
		vTex.x += dsin(time + yTex * period) * wave * power * texelSize.x;
	}
	
	
	gl_FragColor = v_vColour * texture2D(gm_BaseTexture, vTex);
}