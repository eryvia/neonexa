extends State
class_name WalkState

func enter() -> void:
	Global.call_current_state(self)
	player.get_node("AnimatedSprite2D").play("walk")
	
func physics_update(delta):
	var input = Input.get_axis("move_left", "move_right")

	if input == 0:
		Transitioned.emit(self, "IdleState")
	
	player.velocity.x = input * player.speed
	
	player.update_facing(input)

	if Input.is_action_just_pressed("jump"):
		Transitioned.emit(self, "JumpState")

	if not player.is_on_floor():
		Transitioned.emit(self, "FallState")
		
		
