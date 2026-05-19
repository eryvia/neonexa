extends State
class_name IdleState

func enter() -> void:
	#player.player_animation.play("idle")
	pass

func physics_update(delta: float) -> void:
	player.handle_movement(delta)

	var input := Input.get_axis("move_left", "move_right")

	if input != 0.0:
		Transitioned.emit(self, "WalkState")
		return

	if Input.is_action_just_pressed("jump"):
		Transitioned.emit(self, "JumpState")
		return

	if not player.is_on_floor():
		Transitioned.emit(self, "FallState")
