extends Area2D
class_name InteractiveArea

@export var action_name: String = "interact"

var interact: Callable = func():
	pass


func _on_body_entered(body: Node2D) -> void:
	InteractiveManager.register_area(self)


func _on_body_exited(body: Node2D) -> void:
	InteractiveManager.unregister_area(self)
