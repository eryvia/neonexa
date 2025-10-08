extends Node2D

var hovering:bool = false
#These are not real, they are just for the example to work
#what would you do is cursor1 = preaload("pathToFile")
var cursor1
var cursor2

func _on_area_2d_mouse_entered() -> void:
	hovering = true 
	pass # Replace with function body.


func _on_area_2d_mouse_exited() -> void:
	hovering = false
	pass # Replace with function body.
