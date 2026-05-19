extends State
class_name EnemySlashState

var attack_timer := 0.0
var has_hit := false

func enter():
	#parent.get_node("AnimatedSprite2D").play("slash")
	attack_timer = 0.0
	has_hit = false
	parent.can_attack = false
	
	if parent.target:
		var dir = sign(parent.target.global_position.x - parent.global_position.x)
		#parent.get_node("AnimatedSprite2D").flip_h = dir > 0

func physics_update(delta):
	attack_timer += delta
	parent.velocity.x = move_toward(parent.velocity.x, 0, 300 * delta)
	parent.move_and_slide()

	if attack_timer > 0.15 and attack_timer < 0.35 and not has_hit:
		has_hit = true
		_try_hit_player()

	if attack_timer >= 0.6:
		Transitioned.emit(self, "EnemyRunState")

func exit():
	parent.get_tree().create_timer(parent.attack_cooldown_time).timeout.connect(
		func(): parent.can_attack = true
	)

func _try_hit_player():
	if not parent.target: return
	var dist = parent.global_position.distance_to(parent.target.global_position)
	if dist <= parent.attack_range * 1.5:
		if parent.target.has_method("die"):
			parent.target.die()
