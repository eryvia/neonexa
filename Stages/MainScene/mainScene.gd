extends Node2D


var hovering: bool = false
var button_pressed: String = ""

var cursor1
var cursor2

#Input.set_custom_mouse_cursor(cursor1)

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Stages/Prologue/Prologue.tscn")
	pass 

func _on_exit_pressed() -> void:
	get_tree().quit()
	pass
