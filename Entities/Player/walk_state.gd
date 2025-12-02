extends State
class_name MoveState

func enter() -> void:
	Global.call_current_state(self)
	player.get_node("AnimatedSprite2D").play("walk")
	
func physics_update(delta):
	var input = Input.get_axis("move_left", "move_right")
	var animation = player.get_node("AnimatedSprite2D")
	
	if input == 0:
		Transitioned.emit(self, "IdleState")
	
	player.facing_direction = facing_direction(input)
		
	player.velocity.x = input * player.speed
	
	animation.flip_h = player.facing_direction

	if Input.is_action_just_pressed("jump"):
		Transitioned.emit(self, "JumpState")

	if not player.is_on_floor():
		Transitioned.emit(self, "FallState")
		
		
func facing_direction(input):
	if input > 0:
		return 1
	else: 
		return -1
