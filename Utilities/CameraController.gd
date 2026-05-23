extends Camera2D

@export var limit_lerp_speed: float = 3.5

var _target_limits := {
	"left": -10000, "right": 10000,
	"top": -10000, "bottom": 10000
}

func enter_zone(l: int, r: int, t: int, b: int):
	_target_limits = {"left": l, "right": r, "top": t, "bottom": b}

func _process(delta):
	limit_left   = roundi(lerp(float(limit_left),   float(_target_limits.left),   limit_lerp_speed * delta))
	limit_right  = roundi(lerp(float(limit_right),  float(_target_limits.right),  limit_lerp_speed * delta))
	limit_top    = roundi(lerp(float(limit_top),    float(_target_limits.top),    limit_lerp_speed * delta))
	limit_bottom = roundi(lerp(float(limit_bottom), float(_target_limits.bottom), limit_lerp_speed * delta))
