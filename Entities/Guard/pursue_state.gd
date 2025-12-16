extends State
class_name PursueState

func enter():
	var animation = enemy.get_node("AnimatedSprite2D")
	animation.play("attack")

func physics_update(delta):
	var direction = (owner.target.global_position - owner.global_position).normalized()
	owner.velocity = direction * owner.speed
	owner.move_and_slide()

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body == enemy.target:
		enemy.target = null
		Transitioned.emit(self, "EnemyIdleState")
