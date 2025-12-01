extends Node

signal show_area_title(text)

func display_area_title(text: String):
	emit_signal("show_area_title", text)
