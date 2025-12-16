extends State
class_name EnemyIdleState

func enter() -> void:
	var animation = enemy.get_node("AnimatedSprite2D")
	animation.play("idle")

func _on_detection_area_body_entered(body: Player) -> void:
	if body.is_in_group("player"):
		enemy.target = body
		Transitioned.emit(self, "PursueState")
