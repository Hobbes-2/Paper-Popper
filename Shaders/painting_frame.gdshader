shader_type spatial;

uniform sampler2D Painting;
uniform float painting_scale = 1.0;
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float mask = 1.0;
	mask *= texture(Painting, UV * painting_scale + TIME).r * 2.0 - 1.0;
	mask = clamp(mask, 0.0, 1.0);
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
