extends Area2D
class_name CameraZone

@export var limit_left: int = -500
@export var limit_right: int = 500  
@export var limit_top: int = -300
@export var limit_bottom: int = 300
@export var zoom_level: float = 1.0

func _on_body_entered(body):
	if body.is_in_group("player"):
		var cam = body.get_node("Camera2D")
		var tween = create_tween()
		tween.tween_property(cam, "limit_left", limit_left, 0.3)
		tween.tween_property(cam, "limit_right", limit_right, 0.3)
		tween.tween_property(cam, "limit_top", limit_top, 0.3)
		tween.tween_property(cam, "limit_bottom", limit_bottom, 0.3)
		tween.parallel().tween_property(cam, "zoom", Vector2(zoom_level, zoom_level), 0.5)
