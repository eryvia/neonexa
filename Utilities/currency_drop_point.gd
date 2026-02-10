extends Node2D
class_name SoulDropPoint

@export var amount = 10
@onready var timer = $IdleTimer

func _ready() -> void:
	var scene = preload("uid://cyvixke6d5ic2") #Soul Scene
	for x in amount.len():
		var instance = scene.instantiate()
		add_child(instance)
		
		var num = randi() % 50
		instance.position.x = num
		instance.position.y = num
		SignalBus.connect("soul_can_be_harvested", Callable(self, "_soul_can_be_harvested"))
		SignalBus.soul_is_harestable_now()
		
