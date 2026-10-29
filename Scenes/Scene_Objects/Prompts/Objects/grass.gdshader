shader_type spatial;

// Wind sway for foliage, flags, hair and banners. The top of the sprite sways
// most; the bottom row stays anchored.
uniform float strength : hint_range(0.0, 0.15) = 0.04;
uniform float speed : hint_range(0.0, 6.0) = 2.0;

varying vec4 vertex_tint;   // modulate and self_modulate, applied at the end

void vertex() {
	vertex_tint = COLOR;
}

void fragment() {
	vec2 uv = UV;
	float sway = sin(TIME * speed + uv.y * 3.0) * strength * (1.0 - uv.y);
	uv.x += sway;
}
