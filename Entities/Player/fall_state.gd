extends State
class_name FallState

func enter() -> void:
	Global.call_current_state(self)
	player.get_node("AnimatedSprite2D").play("fall")


func physics_update(delta: float) -> void:
	player.velocity.y += player.gravity * delta

	var input := Input.get_axis("move_left", "move_right")
	player.velocity.x = input * player.speed

	player.update_facing(input)
	
	if player.is_on_floor():
		player.current_jumps = player.max_jumps
		if input == 0:
			Transitioned.emit(self, "IdleState")
		else:
			Transitioned.emit(self, "WalkState")
		return

		
	if Input.is_action_just_pressed("jump"):
		if player.current_jumps < 1:
			pass
		else:
			player.current_jumps -= 1
			Transitioned.emit(self, "JumpState")
