extends State
class_name SoulLevitate

func enter() -> void:
	parent.vel = Vector2.ZERO
	parent.soul_timer.start()

func physics_update(delta: float) -> void:
	parent.position.y += sin(Time.get_ticks_msec() * 0.003) * 0.5
