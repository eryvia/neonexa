extends State

func enter(): 
	parent.animation.play("jump_in")

func _on_enemy_jumper_target_entered() -> void:
	Transitioned.emit(self, "JumpState")
	pass # Replace with function body.
