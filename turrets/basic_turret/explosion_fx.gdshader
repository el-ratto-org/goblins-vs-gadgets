shader_type spatial;

uniform float explosion_age = 0.0;
uniform float twist_speed = 10.0;

uniform sampler2D noise;



void fragment() {
	vec3 color = texture(noise, UV+TIME/twist_speed).rgb;
	float alpha = texture(noise, UV+TIME/twist_speed).b;
	color.r += .5;
	color.g -= .5;
	color.b -= .5;
	alpha *= explosion_age;
	ALBEDO = color;
	ALPHA = alpha;
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
