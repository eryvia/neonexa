extends Node

signal show_area_title(text)
signal hide_are_title()
signal soul_can_be_harvested()

func display_area_title(text: String):
	emit_signal("show_area_title", text)

func soul_can_be_harvested_now():
	soul_can_be_harvested.emit()
