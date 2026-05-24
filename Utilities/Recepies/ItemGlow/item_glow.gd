# ItemGlow.gd
extends PointLight2D

@export var glow_color: Color = Color(0.4, 0.8, 1.0)  # cyan by default
@export var glow_radius: float = 60.0
@export var pulse: bool = true
@export var pulse_speed: float = 2.0

func _ready() -> void:
	color = glow_color
	texture_scale = glow_radius / 128.0
	energy = 0.8

	if texture == null:
		texture = _make_radial_gradient()

func _process(_delta: float) -> void:
	if pulse:
		energy = 0.7 + sin(Time.get_ticks_msec() * 0.001 * pulse_speed) * 0.15

func _make_radial_gradient() -> GradientTexture2D:
	var grad := Gradient.new()
	grad.add_point(0.0, Color(1, 1, 1, 1))
	grad.add_point(1.0, Color(1, 1, 1, 0))

	var tex := GradientTexture2D.new()
	tex.gradient = grad
	tex.fill = GradientTexture2D.FILL_RADIAL
	tex.fill_from = Vector2(0.5, 0.5)
	tex.fill_to = Vector2(1.0, 0.5)
	tex.width = 128
	tex.height = 128
	return tex
