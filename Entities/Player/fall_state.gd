extends State
class_name FallState

var in_hang_phase := false
var hang_step := 0
var gravity_scale := 1.0

func enter() -> void:
	player.player_animation.play("fall")
	if player.start_hang_phase:
		in_hang_phase = true
		hang_step = 0
		gravity_scale = player.hang_time_gravity_start
		player.start_hang_phase = false
	else:
		in_hang_phase = false
		gravity_scale = 1.0

func physics_update(delta: float) -> void:
	if in_hang_phase:
		if not Input.is_action_pressed("jump"):
			in_hang_phase = false
			gravity_scale = 1.0
		elif hang_step >= player.hang_time_steps_max:
			in_hang_phase = false
			gravity_scale = 1.0
		else:
			var progress := float(hang_step) / float(player.hang_time_steps_max)
			gravity_scale = lerpf(player.hang_time_gravity_start, 1.0, progress)
			hang_step += 1

	player.velocity.y = move_toward(
		player.velocity.y,
		player.fall_velocity,
		player.fall_gravity * gravity_scale * delta
	)
	player.velocity.y = minf(player.velocity.y, player.terminal_velocity)

	var input := Input.get_axis("move_left", "move_right")

	if player.is_on_floor():
		player.current_jumps = player.max_jumps
		if player.consume_jump_buffer():
			Transitioned.emit(self, "JumpState")
		elif input == 0.0:
			Transitioned.emit(self, "IdleState")
		else:
			Transitioned.emit(self, "WalkState")
		return

	player.handle_movement(delta)
	player.update_facing(input)

	if Input.is_action_just_pressed("jump"):
		if player.consume_coyote_or_double():
			Transitioned.emit(self, "JumpState")
			return
		else:
			player.buffer_jump()

	if Input.is_action_just_pressed("dash") and player.can_dash:
		Transitioned.emit(self, "DashState")
