extends State           
class_name AttackState

@export var active_time := 0.08  
@export var total_time := 0.20   
@export var attack_cooldown := 0.1 

var t := 0.0
var on_cooldown := false

func enter() -> void:
	
	if on_cooldown:
		Transitioned.emit(self, "IdleState")
		return
		
	player.is_attacking = true
	t = 0.0
	
	player.player_attack_anim.visible = true
	player.player_attack_anim.play("default_slash")
	player.get_node("AnimatedSprite2D").play("attack")
	
	player.attack_hitbox.scale.x = -1 if player.facing_direction == 1 else 1

func physics_update(delta: float) -> void:
	t += delta

	var input = Input.get_axis("move_left", "move_right")
	player.velocity.x = input * player.speed
	player.update_facing(input) 

	if t >= 0.06 and t <= 0.06 + active_time:
		player.enable_attack_hitbox()
	else:
		player.disable_attack_hitbox()

	if t >= total_time:
		start_cooldown()
		player.is_attacking = false
		if not player.is_on_floor():
			Transitioned.emit(self, "FallState")
		elif input != 0:
			Transitioned.emit(self, "WalkState")
		else:
			Transitioned.emit(self, "IdleState")

func start_cooldown():
	on_cooldown = true
	await get_tree().create_timer(attack_cooldown).timeout
	on_cooldown = false
