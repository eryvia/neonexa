extends Node
class_name State

signal transitioned(state: State, new_state_name: String)

var player

func Enter():
	pass
	
func Exit():
	pass
	
func Update(_delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	pass
