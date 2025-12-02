extends Node

signal show_area_title(text)
signal hide_are_title()

func display_area_title(text: String):
	emit_signal("show_area_title", text)
