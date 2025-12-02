extends State
class_name JumpState


func enter() -> void:
	Global.call_current_state(self)
	var animation = player.get_node($AnimatedSprite2D)
	animation.play()
	

func physics_update(delta: float) -> void:
	pass
