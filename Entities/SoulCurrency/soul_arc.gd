extends State
class_name SoulArc

func enter() -> void:
	parent.vel = Vector2(randf_range(-60.0, 60.0), randf_range(-180.0, -120.0))

func physics_update(delta: float) -> void:
	parent.vel.y += 400 * delta
	parent.position += parent.vel * delta
	if parent.vel.y >= 0:
		Transitioned.emit(self, "SoulLevitate")
