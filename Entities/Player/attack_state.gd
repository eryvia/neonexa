extends State           
class_name AttackState

@export var active_time := 0.08  
@export var total_time := 0.20    

var t := 0.0

func enter() -> void:             
	var animation = player.get_node("AnimatedSprite2D")                                           
	t = 0.0
	player.velocity.x = 0 
	player.anim.play("basic_attack")
	player.disable_attack_hitbox()
	animation.play("attack")

func physics_update(delta: float) -> void:
	t += delta

	if t >= 0.06 and t <= 0.06 + active_time:
		player.enable_attack_hitbox()
	else:
		player.disable_attack_hitbox()

	if t >= total_time:
		player.disable_attack_hitbox()
		Transitioned.emit(self, "IdleState")
