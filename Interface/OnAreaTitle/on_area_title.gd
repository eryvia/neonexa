extends Control

func _ready():
	SignalBus.connect("show_area_title", Callable(self, "_on_show_area_title"))

func _on_show_area_title(text: String):
	$Label.text = text
	$AnimationPlayer.play("fade_in")
