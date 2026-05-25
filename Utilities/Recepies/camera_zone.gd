extends Area2D

@export var limit_left: int = -320
@export var limit_right: int = 320
@export var limit_top: int = -180
@export var limit_bottom: int = 180

func _ready():
	await get_tree().process_frame
	for body in get_overlapping_bodies():
		_on_body_entered(body)

func _on_body_entered(body: Node2D):
	if not body.is_in_group("player"):
		return
	# Find camera in scene root instead of inside player
	var cam = get_tree().get_first_node_in_group("main_camera")
	if cam and cam.has_method("enter_zone"):
		print("hit")
		cam.enter_zone(limit_left, limit_right, limit_top, limit_bottom)
