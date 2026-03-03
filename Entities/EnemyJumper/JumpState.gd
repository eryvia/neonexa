extends State

func enter(): 
	launch_arc_toward(parent.target)
	parent.animation.play("jump_in")
	pass
	
func launch_arc_toward(target_position: Vector2) -> void:
	var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	var displacement = target_position - parent.global_position
	var velocity_x = displacement.x / parent.launch_time
	var velocity_y = (displacement.y / parent.launch_time) - (0.5 * gravity * parent.launch_time)
	parent.linear_velocity = Vector2(velocity_x, velocity_y)
