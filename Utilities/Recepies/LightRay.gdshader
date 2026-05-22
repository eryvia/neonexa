shader_type canvas_item;
render_mode blend_add;

uniform vec4 ray_color : source_color = vec4(0.95, 0.93, 0.7, 1.0);
uniform float softness : hint_range(0.0, 0.5) = 0.25;
uniform float flicker_speed = 1.2;
uniform float sway = 0.04;

void fragment() {
    vec2 uv = UV;
    uv.x += sin(uv.y * 3.0 + TIME * 0.5) * sway;          // jemnej pohyb
    float edge = smoothstep(0.5, 0.5 - softness, abs(uv.x - 0.5)); // boční falloff
    float vert = 1.0 - uv.y;                               // shora dolů slábne
    float flick = 0.85 + 0.15 * sin(TIME * flicker_speed); // dýchání
    COLOR = vec4(ray_color.rgb, edge * vert * flick * ray_color.a);
}