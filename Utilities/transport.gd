extends Area2D
class_name Door

@export var door_id: String = ""
@export var target_scene: String = ""
@export var target_door_id: String = ""

@onready var _spawn_point: Marker2D = $SpawnPoint

var _armed: bool = true

func _ready():
	add_to_group("doors")
	body_exited.connect(_on_body_exited)

func get_door_id() -> String:
	return door_id

func get_spawn_position() -> Vector2:
	if _spawn_point:
		return _spawn_point.global_position
	return global_position

# Player spawned ON this door — don't let it fire until they step off
func disarm():
	_armed = false

func _on_body_entered(body: Node2D):
	if not _armed or not body.is_in_group("player"):
		return
	SceneManager.use_door(target_scene, target_door_id)

func _on_body_exited(body: Node2D):
	if body.is_in_group("player"):
		_armed = true
