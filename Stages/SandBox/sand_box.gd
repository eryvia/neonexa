extends Node2D

func _ready() -> void:
	$Utils/FadeTransition/AnimationPlayer.play("fade_out")
	SignalBus.display_area_title("Old Intake Sector")
