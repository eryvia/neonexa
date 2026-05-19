shader_type canvas_item;

uniform vec3 glow_color : source_color = vec3(0.58, 0.78, 0.27);
uniform float glow_intensity : hint_range(0.0, 5.0) = 2.0;
uniform float glow_size : hint_range(0.0, 3.0) = 1.0;
uniform float pulse_speed : hint_range(0.0, 5.0) = 1.5;
uniform float pulse_amount : hint_range(0.0, 1.0) = 0.3;

void fragment() {
	vec4 color = texture(TEXTURE, UV);

	float green_amount = color.g - max(color.r, color.b);

	if (green_amount > 0.15 && color.a > 0.5) {
		float pulse = 1.0 + sin(TIME * pulse_speed) * pulse_amount;
		float glow = green_amount * glow_intensity * pulse;

		color.rgb += glow_color * glow;

		vec2 pixel_size = TEXTURE_PIXEL_SIZE * glow_size;
		for (int x = -1; x <= 1; x++) {
			for (int y = -1; y <= 1; y++) {
				if (x == 0 && y == 0) continue;
				vec2 offset = vec2(float(x), float(y)) * pixel_size;
				vec4 neighbor = texture(TEXTURE, UV + offset);
				float neighbor_green = neighbor.g - max(neighbor.r, neighbor.b);
				if (neighbor_green > 0.15 && neighbor.a > 0.5) {
					color.rgb += glow_color * glow * 0.15;
				}
			}
		}
	}

	COLOR = color;
}