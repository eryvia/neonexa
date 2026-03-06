extends Node2D

func _ready() -> void:
	$FadeTransition.show()
	$FadeTransition/AnimationPlayer.play("fade_in")
