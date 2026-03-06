extends State
class_name SoulSuck

func physics_update(delta: float) -> void:
	var dir = (Global.player.position - parent.global_position).normalized()
	parent.position += dir * 200 * delta
