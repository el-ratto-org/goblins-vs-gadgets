shader_type canvas_item;

varying vec4 color;


void vertex() {
	VERTEX.x -= (UV.y - 0.075) * 60.0;
	color = COLOR;
}

void fragment() {
	COLOR = texture(TEXTURE, UV).rgba * color;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
