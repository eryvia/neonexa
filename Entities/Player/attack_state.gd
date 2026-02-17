extends State           
class_name AttackState

@export var active_time := 0.08  
@export var total_time := 0.20    

var t := 0.0

func enter() -> void:
	
	player.attack_hitbox.scale.x = -1 if player.facing_direction == 1 else 1
		
	player.disable_attack_hitbox()

	t = 0.0
	var slash: AnimatedSprite2D = player.player_attack_anim
	slash.visible = true
	slash.stop()
	slash.frame = 0
	
	var sf := slash.sprite_frames
	if sf and sf.has_animation("default_slash"):
		sf.set_animation_loop("default_slash", false)
	
	var animation = player.get_node("AnimatedSprite2D")                                           

	player.player_attack_anim.visible = true
	player.player_attack_anim.play("default_slash")
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
