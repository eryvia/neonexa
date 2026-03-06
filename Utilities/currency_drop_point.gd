extends Node2D
class_name SoulDropPoint

@export var soul_scene: PackedScene = preload("uid://cyvixke6d5ic2")

func currency_drop(amount):
	for i in range(amount):
		var soul := soul_scene.instantiate() as Soul
		call_deferred("add_child", soul)

		soul.position = Vector2(randi_range(-25, 25), -randi_range(10, 50))
	
	await get_tree().create_timer(0.6).timeout
	SignalBus.soul_can_be_harvested_now()
