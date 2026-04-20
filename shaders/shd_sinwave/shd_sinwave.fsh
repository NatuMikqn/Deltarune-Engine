// SinWave by NatuMikqn
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float time;
uniform float width;
uniform float height;
uniform float strength;
uniform bool vertical;
uniform vec2 texelSize;

const float PI = 3.14159265359;

float dsin(float value)
{
	return sin(value * PI / 180.0);
}

void main()
{
	vec2 vTex = v_vTexcoord;
	vec2 scaleFactor = 1.0 / texelSize / height;
	vec2 wave = (v_vTexcoord - 0.5);
	if (strength > 0.0) {
		vec2 stepSize = 1.0 / texelSize / strength;
		wave = floor(wave * stepSize) / stepSize;
	}
	wave *= scaleFactor * 360.0;
	
	if (vertical) {
		vTex.y += dsin(time + wave.x) * width * texelSize.x;
	} else {
		vTex.x += dsin(time + wave.y) * width * texelSize.x;
	}
	
	gl_FragColor = v_vColour * texture2D(gm_BaseTexture, vTex);
}