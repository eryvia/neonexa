extends Node2D

@export var next_scene: String = "res://scenes/area_2.tscn"
@onready var interaction_area: InteractiveArea = $InteractiveArea  # <-- matches your node name

func _ready() -> void:
	interaction_area.action_name = "open gate"
	interaction_area.interact = _on_interact

func _on_interact():
	if Global.has_item("rusty_key"):
		Global.remove_item("rusty_key")
		Global.advance_quest("escape")
		interaction_area.set_deferred("monitoring", false)
		InteractiveManager.unregister_area(interaction_area)
		get_tree().change_scene_to_file(next_scene)
	else:
		if Global.is_active("escape") and Global.quests["escape"]["step"] == 0:
			Global.advance_quest("escape")
		DialogueManager.start_dialog(global_position, ["The gate is sealed tight. It needs a key."])
		while DialogueManager.is_dialog_active:
			await get_tree().process_frame
