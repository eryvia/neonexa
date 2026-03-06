extends State
class_name DashState

var dash_timer := 0.0
var dash_direction := 1.0

func enter() -> void:
	dash_timer = player.dash_duration
	
	dash_direction = 1.0 if player.get_node("AnimatedSprite2D").flip_h == false else -1.0
	#player.get_node("AnimatedSprite2D").play("dash")
	player.velocity.y = 0  # no gravity during dash

func physics_update(delta: float) -> void:
	dash_timer -= delta

	# stop at walls — move_and_slide handles collision, just check if we hit something
	player.velocity.x = player.dash_velocity * dash_direction
	player.velocity.y = 0  # cancel gravity during dash
	player.move_and_slide()

	# wall collision — stop dash early
	if player.get_slide_collision_count() > 0:
		for i in player.get_slide_collision_count():
			var col = player.get_slide_collision(i)
			if abs(col.get_normal().x) > 0.5:  # hit a wall
				Transitioned.emit(self, "IdleState")
				return

	if dash_timer <= 0:
		Transitioned.emit(self, "IdleState")

func exit() -> void:
	player.start_dash_cooldown()  # call this on player to prevent spam
