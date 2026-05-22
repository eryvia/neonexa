extends Area2D
class_name Transport

@export var target_scene: String = "res://scenes/cave_area.tscn"
@export var entry_point: String = "from_verdant_veins"

func _on_body_entered(body):
	if body.is_in_group("player"):
		SceneManager.transition_to(target_scene, entry_point)
		

"""
extends Area2D
class_name Transport

@export var target_level: String = "OldIntakeSector"
@export var target_spawn: String = "default"

var _can_travel := true

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and _can_travel:
		print("player done")
		_can_travel = false
		LevelManager.travel_to(target_level, target_spawn)
		
"""
