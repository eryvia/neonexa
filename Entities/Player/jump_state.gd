extends State
class_name JumpState

var step := 0

func enter() -> void:
	var is_air_jump = not player.is_on_floor() and player.coyote_timer <= 0.0
	if is_air_jump:
		var dj = player.double_jump_animation
		dj.visible = true
		dj.frame = 0
		dj.play("double_jump")
		
	player.player_animation.play("jump")
	player.velocity.y = player.jump_velocity
	player.current_jumps -= 1
	player.coyote_timer = 0.0
	player.start_hang_phase = false
	step = 0

func physics_update(delta: float) -> void:
	"""
		if player.right_outer.is_colliding() && !player.right_inner.is_colliding() && !player.left_outer.is_colliding() && !player.left_inner.is_colliding(): 
			player.global_position += 5
		if !player.right_outer.is_colliding() && !player.right_inner.is_colliding() && player.left_outer.is_colliding() && !player.left_inner.is_colliding(): 
			player.global_position -= 5
	"""
		
	if step < player.jump_steps_max and Input.is_action_pressed("jump"):
		player.velocity.y = player.jump_velocity
		step += 1
	else:
		if step >= player.jump_steps_max and Input.is_action_pressed("jump"):
			player.start_hang_phase = true
		else:
			if player.velocity.y < 0.0:
				player.velocity.y *= player.jump_release_multiplier
		Transitioned.emit(self, "FallState")
		return

	var input := Input.get_axis("move_left", "move_right")
	player.handle_movement(delta)
	player.update_facing(input)

	if Input.is_action_just_pressed("jump") and player.current_jumps > 0:
		Transitioned.emit(self, "JumpState")
		return

	if Input.is_action_just_pressed("dash") and player.can_dash:
		Transitioned.emit(self, "DashState")
