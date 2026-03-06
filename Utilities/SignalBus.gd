extends Node

signal show_area_title(text: String)
signal hide_are_title()
signal soul_can_be_harvested()
signal souls_changed(amount: int)

func display_area_title(text: String):
	show_area_title.emit(text)
	
func soul_can_be_harvested_now() -> void:
	soul_can_be_harvested.emit()
