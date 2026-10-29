shader_type spatial;
render_mode depth_draw_opaque;

// Das hier erstellt die "Schnittstelle" zum Inspektor
uniform sampler2D meine_textur : source_color, filter_nearest;
uniform float strength : hint_range(0.0, 0.15) = 0.04;
uniform float speed : hint_range(0.0, 6.0) = 2.0;
varying vec4 vertex_tint;


void vertex() {
    vertex_tint = COLOR;
}

void fragment() {
    // Hole die Farbe aus der Textur, die du im Inspektor reinziehst
    vec4 tex_color = texture(meine_textur, UV);
    
    ALBEDO = tex_color.rgb;
    ALPHA = tex_color.a; 
	
	vec2 uv = UV;
    float sway = sin(TIME * speed + uv.y * 3.0) * strength * (1.0 - uv.y);
    uv.x += sway;
    
	if (tex_color.a < 0.1) {
        discard; // Verwirft das Pixel komplett (keine Tiefen- oder Schattenberechnung dafür)
    }
	
    tex_color = texture(meine_textur, uv);
    ALBEDO = tex_color.rgb * vertex_tint.rgb;
    ALPHA = tex_color.a * vertex_tint.a;
}
