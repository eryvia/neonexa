extends State
class_name GroundEnemySlashState

@onready var Hitbox: Area2D = $AttackArea

func enter():
	Hitbox.Monitoring = false

func physics_update(delta: float) -> void:
	
	Hitbox.Monitoring = false
	pass
