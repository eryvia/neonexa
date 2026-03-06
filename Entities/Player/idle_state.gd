extends  State
class_name IdleState

func enter() -> void:
	player.velocity.x = 0
	#Global.call_current_state(self)
	var animation = player.get_node("AnimatedSprite2D")
	animation.play("idle")
	#animation.flip_h = player.facing_direction == -1

func update(delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		Transitioned.emit(self, "JumpState")
	if Input.is_action_just_pressed("attack") and not player.attack_cooldown:
		player.perform_attack()

func physics_update(delta: float) -> void:
	var input = Input.get_axis("move_left", "move_right")
	if input != 0:
		Transitioned.emit(self, "WalkState")

	if not player.is_on_floor():
		Transitioned.emit(self, "FallState")
