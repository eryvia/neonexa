# PlayerLight.gd
extends PointLight2D

@export var base_energy: float = 1.2
@export var radius: float = 150.0
@export var flicker_enabled: bool = false
@export var flicker_speed: float = 6.0
@export var flicker_intensity: float = 0.08

func _ready() -> void:
	texture_scale = radius / 128.0  # assumes 256px texture, adjust if needed
	energy = base_energy

	if texture == null:
		texture = _make_radial_gradient()

func _process(_delta: float) -> void:
	if flicker_enabled:
		energy = base_energy + sin(Time.get_ticks_msec() * 0.001 * flicker_speed) * flicker_intensity

func _make_radial_gradient() -> GradientTexture2D:
	var grad := Gradient.new()
	grad.add_point(0.0, Color(1.0, 0.95, 0.85, 1.0))  # warm center
	grad.add_point(0.6, Color(1.0, 0.9, 0.7, 0.4))
	grad.add_point(1.0, Color(1.0, 1.0, 1.0, 0.0))    # fade to transparent

	var tex := GradientTexture2D.new()
	tex.gradient = grad
	tex.fill = GradientTexture2D.FILL_RADIAL
	tex.fill_from = Vector2(0.5, 0.5)
	tex.fill_to = Vector2(1.0, 0.5)
	tex.width = 256
	tex.height = 256
	return tex
