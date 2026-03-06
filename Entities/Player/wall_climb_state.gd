extends State
class_name WallSlideState

var wall_direction := 0


func enter() -> void:
	#player.get_node("AnimatedSprite2D").play("wall_slide") 
	player.velocity.y = 0

func physics_update(delta: float) -> void:
	player.velocity.y = move_toward(player.velocity.y, player.wall_velocity, player.wall_gravity * delta)
	
	wall_direction = _get_wall_direction()
	
	#player.get_node("AnimatedSprite2D").flip_h = wall_direction > 0
	
	player.velocity.x = wall_direction * 20.0
	player.move_and_slide()
	
	if Input.is_action_just_pressed("jump"):
		player.velocity.x = -wall_direction * player.walk_velocity * 1.5
		player.velocity.y = player.jump_velocity
		player.current_jumps = player.max_jumps - 1
		Transitioned.emit(self, "JumpState")
		return
	
	# let go of wall
	if not player.is_on_wall():
		Transitioned.emit(self, "FallState")
		return
	
	var input := Input.get_axis("move_left", "move_right")
	if input != 0 and signf(input) != wall_direction:
		Transitioned.emit(self, "FallState")
		return
	
	if player.is_on_floor():
		Transitioned.emit(self, "IdleState")
		return

func exit() -> void:
	pass

func _get_wall_direction() -> int:
	if player.is_on_wall():
		var col = player.get_last_slide_collision()
		if col:
			return -int(sign(col.get_normal().x))
	return 0
