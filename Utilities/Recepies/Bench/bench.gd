extends Node2D
@onready var interaction_area: InteractiveArea = $InteractiveArea

func _ready():
	interaction_area.action_name = "rest"
	interaction_area.interact = _on_interact

func _on_interact():
	Global.respawn_position = global_position
	Global.respawn_scene = get_tree().current_scene.scene_file_path
	Global.hp = 5  
	DialogueManager.start_dialog(global_position, ["..."])
	while DialogueManager.is_dialog_active:
		await get_tree().process_frame
