extends State
class_name FallState

func enter() -> void:
	Global.call_current_state(self)


func physics_update(delta: float) -> void:
	player.velocity.y += player.gravity * delta

	var input := Input.get_axis("move_left", "move_right")
	player.velocity.x = input * player.speed

	if player.is_on_floor():
		player.jumps = 2 
		if input == 0:
			Transitioned.emit(self, "IdleState")
		else:
			Transitioned.emit(self, "MoveState")
		return

	# Allow mid-air jump
	if Input.is_action_just_pressed("jump"):
		if player.jumps < 1:
			pass
		else:
			player.jumps -= 1
			Transitioned.emit(self, "JumpState")
