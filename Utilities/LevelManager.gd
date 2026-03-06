extends Node

const LEVELS: Dictionary = {
	"OldIntakeSector": "uid://cm8sesolaxcvv",
	"Prologue": "uid://c04it1lgwtnka"
}

var current_level: String = "Prologue"
var target_spawn: String = "default"

func travel_to(level_name: String, spawn_point: String = "default") -> void:
	target_spawn = spawn_point
	current_level = level_name
	
	var fade = get_tree().get_first_node_in_group("fade_transition")
	if fade:
		fade.show()
		fade.get_node("AnimationPlayer").play("fade_in")
		await fade.get_node("AnimationPlayer").animation_finished
	_load_level(level_name)

func _load_level(level_name: String) -> void:
	var path = LEVELS.get(level_name)
	if path:
		get_tree().paused = true
		await get_tree().create_timer(0.8, true).timeout 
		get_tree().paused = false
		get_tree().call_deferred("change_scene_to_file", path)
	else:
		push_error("LevelManager: level not found → " + level_name)
