extends State
class_name EnemyRunState

#func enter():
	#parent.get_node("AnimatedSprite2D").play("run")

func physics_update(delta):
	if not parent.target:
		Transitioned.emit(self, "EnemyIdleState")
		return

	var dist = parent.global_position.distance_to(parent.target.global_position)
	var dir = sign(parent.target.global_position.x - parent.global_position.x)

	parent.get_node("AnimatedSprite2D").flip_h = dir > 0

	parent.velocity.x = dir * parent.run_speed
	parent.velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta
	parent.move_and_slide()

	if parent.can_attack:
		if dist <= parent.attack_range:
			Transitioned.emit(self, "EnemySlashState")
			return
		if dist > parent.leap_range:
			Transitioned.emit(self, "EnemyLeapState")
			return

	if not parent.isDetecting:
		Transitioned.emit(self, "EnemyIdleState")
