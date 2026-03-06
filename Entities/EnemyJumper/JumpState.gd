extends State
class_name EnemyLeapState

func enter():
	parent.get_node("AnimatedSprite2D").play("jump")
	if parent.target:
		_launch()

func _launch():
	var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	var displacement = parent.target.global_position - parent.global_position
	var vx = displacement.x / parent.launch_time
	var vy = (displacement.y / parent.launch_time) - (0.5 * gravity * parent.launch_time)
	parent.velocity = Vector2(vx, vy)

func physics_update(delta):
	parent.velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta
	parent.move_and_slide()

	if parent.is_on_floor() and parent.velocity.y >= 0:
		var dist = parent.global_position.distance_to(parent.target.global_position)
		if dist <= parent.attack_range and parent.can_attack:
			Transitioned.emit(self, "EnemySlashState")
		else:
			Transitioned.emit(self, "EnemyRunState")
