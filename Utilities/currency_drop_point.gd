extends Node2D
class_name SoulDropPoint

@export var amount := 4
@export var soul_scene: PackedScene = preload("uid://cyvixke6d5ic2")

func currency_drop(amount):
	for i in amount:
		var soul := soul_scene.instantiate() as Soul
		add_child(soul)

		soul.position = Vector2(randi() % 50, (randi() % 50) / 2)
	
	await get_tree().create_timer(0.6).timeout
	SignalBus.soul_can_be_harvested_now()
