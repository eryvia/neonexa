extends State
class_name EnemyHurtState

var timer := 0.0

func enter():
	#parent.get_node("AnimatedSprite2D").play("hurt")
	timer = 0.0
	# knock back
	if parent.target:
		var dir = sign(parent.global_position.x - parent.target.global_position.x)
		parent.velocity.x = dir * 150.0
		parent.velocity.y = -100.0

func physics_update(delta):
	timer += delta
	parent.velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta
	parent.velocity.x = move_toward(parent.velocity.x, 0, 400 * delta)
	parent.move_and_slide()
	if timer >= 0.3:
		Transitioned.emit(self, "EnemyRunState")
