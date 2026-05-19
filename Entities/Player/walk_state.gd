extends State
class_name WalkState

func enter() -> void:
	player.player_animation.play("walk")

func physics_update(delta: float) -> void:
	var input := Input.get_axis("move_left", "move_right")

	player.handle_movement(delta)
	player.update_facing(input)

	if input == 0.0:
		Transitioned.emit(self, "IdleState")
		return

	if Input.is_action_just_pressed("jump"):
		Transitioned.emit(self, "JumpState")
		return

	if not player.is_on_floor():
		player.grant_coyote()
		Transitioned.emit(self, "FallState")
		return

	if Input.is_action_just_pressed("dash") and player.can_dash:
		Transitioned.emit(self, "DashState")
