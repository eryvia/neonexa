extends Area2D
class_name Ore

@export var hp = 4 
@onready var collision_ore = $CollisionShape2D

func _ready() -> void:
	pass

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_attack"):
		hp -= 1
		if hp == 0:
			queue_free()
		
