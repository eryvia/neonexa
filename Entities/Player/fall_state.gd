extends State
class_name FallState

func enter() -> void:
	#Global.call_current_state(self)
	player.get_node("AnimatedSprite2D").play("fall")

func physics_update(delta: float) -> void:
	#player.velocity.y += player.gravity * delta
	player.velocity.y = move_toward(player.velocity.y, player.fall_velocity, player.fall_gravity * delta)
	
	var input := Input.get_axis("move_left", "move_right")

	if player.is_on_floor():
		player.current_jumps = player.max_jumps
		if input == 0:
			Transitioned.emit(self, "IdleState")
		else:
			Transitioned.emit(self, "WalkState")
		return
	player.handle_movement()
	player.update_facing(input)
		
	if Input.is_action_just_pressed("jump") and player.current_jumps > 0:
		player.current_jumps -= 1
		Transitioned.emit(self, "JumpState")

	if Input.is_action_just_pressed("dash") and player.can_dash:
		Transitioned.emit(self, "DashState")
		
	if Input.is_action_just_pressed("jump"):
		if player.current_jumps < 1:
			pass
		else:
			player.current_jumps -= 1
			Transitioned.emit(self, "JumpState")
