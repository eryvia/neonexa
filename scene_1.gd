extends Node2D

var hovering: bool = false
#These are not real, they are just for the example to work
#what would you do is cursor1 = preaload("pathToFile")
var cursor1
var cursor2

func _on_area_2d_mouse_entered() -> void:
	hovering = true
	Input.set_custom_mouse_cursor(cursor1)


func _on_area_2d_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(cursor2)
	hovering = false


func _input(event: InputEvent) -> void:
	if hovering and Input.is_action_just_pressed("click"):
		pass
