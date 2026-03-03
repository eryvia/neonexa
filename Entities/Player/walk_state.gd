extends State
class_name WalkState

func enter() -> void:
	#Global.call_current_state(self)
	if not player.is_attacking:
		player.get_node("AnimatedSprite2D").play("walk")
		
func physics_update(delta):
	var input = Input.get_axis("move_left", "move_right")
	player.velocity.x = input * player.speed
	player.update_facing(input)
	
	if not player.is_attacking:
		if input == 0:
			player.get_node("AnimatedSprite2D").play("idle")
		else:
			player.get_node("AnimatedSprite2D").play("walk")

	if Input.is_action_just_pressed("attack") and not player.attack_cooldown:
		player.perform_attack()

	if input == 0: Transitioned.emit(self, "IdleState")
	if Input.is_action_just_pressed("jump"): Transitioned.emit(self, "JumpState")
	if not player.is_on_floor(): Transitioned.emit(self, "FallState")
