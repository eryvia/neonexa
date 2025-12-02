extends Area2D
class_name Shire

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_rest()
		print("Player entered!")

func player_rest():
	if Input.is_action_just_pressed("shire_rest"):
		pass
