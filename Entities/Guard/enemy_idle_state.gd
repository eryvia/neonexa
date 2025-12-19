extends State
class_name EnemyIdleState

func enter() -> void:
	Global.call_current_state(self)
	var animation = parent.get_node("AnimatedSprite2D")
	animation.play("idle")

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		parent.target = body
		Transitioned.emit(self, "PursueState")
