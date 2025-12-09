extends State
class_name JumpState

func enter() -> void:
	Global.call_current_state(self)
	player.get_node("AnimatedSprite2D").play("jump")
	player.velocity.y = player.jump_velocity
	player.current_jumps -= 1
	
func physics_update(delta: float) -> void:
	player.velocity.y += player.gravity * delta

	var input := Input.get_axis("move_left", "move_right")
	player.velocity.x = input * player.speed

	player.update_facing(input)

	if player.velocity.y > 0:
		Transitioned.emit(self, "FallState")
		return

	if Input.is_action_just_pressed("jump") and player.current_jumps > 0:
		Transitioned.emit(self, "JumpState")
		return

	"""
	if no frame idk
	
	if player.is_on_floor():
		player.jumps = 2
		if input == 0:
			Transitioned.emit(self, "IdleState")
		else:
			Transitioned.emit(self, "MoveState")
	"""
