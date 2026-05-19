shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_linear;

uniform float vignette_intensity : hint_range(0.0, 1.0) = 0.4;
uniform float vignette_softness : hint_range(0.0, 1.0) = 0.45;

uniform float desaturation : hint_range(0.0, 1.0) = 0.3;
uniform vec3 tint_color : source_color = vec3(0.7, 0.78, 0.88);
uniform float tint_strength : hint_range(0.0, 1.0) = 0.15;

void fragment() {
	vec4 color = texture(screen_texture, SCREEN_UV);

	float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114));
	color.rgb = mix(color.rgb, vec3(gray), desaturation);

	color.rgb = mix(color.rgb, color.rgb * tint_color, tint_strength);

	vec2 center = SCREEN_UV - vec2(0.5);
	float dist = length(center);
	float vignette = smoothstep(vignette_softness, vignette_softness + 0.35, dist);
	color.rgb *= (1.0 - vignette * vignette_intensity);

	COLOR = color;
}