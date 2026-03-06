extends Node

const LEVELS: Dictionary = {
	"sandbox": "uid://c80maj2vdho5i",
	"mainScene": "uid://dn0d1brp825vr"
}

var current_level: String = "sandbox"
var target_spawn: String = "default"

func travel_to(level_name: String, spawn_point: String = "default") -> void:
	target_spawn = spawn_point
	current_level = level_name
	TransitionScreen.flash(func(): _load_level(level_name))

func _load_level(level_name: String) -> void:
	var path = LEVELS.get(level_name)
	if path:
		get_tree().change_scene_to_file(path)
	else:
		push_error("LevelManager: level not found → " + level_name)
