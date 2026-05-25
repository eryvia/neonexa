extends Node2D
@onready var interaction_area: InteractiveArea = $InteractiveArea
@onready var animS = $AnimatedSprite2D

const lines: Array[String] = [
	"Hi.. so it work",
	"I was the one who gave you soul",
	"I dont have much time",
	"But you need to destroy the core",
	"Take this -> you'll need to climb where others can't.",
]

func _ready():
	interaction_area.action_name = "talk"
	interaction_area.interact = _on_interact

func _on_interact():
	var player = get_tree().get_first_node_in_group("player")
	var was_fresh := not Global.quests.has("the_core")

	var to_say := lines if was_fresh else ["The core still waits. Climb, and end it."]
	DialogueManager.start_dialog(global_position, to_say)
	if player:
		animS.flip_h = player.global_position.x > global_position.x
	while DialogueManager.is_dialog_active:
		await get_tree().process_frame

	if was_fresh:
		Global.start_quest("the_core")
		#Global.grant_ability("wallclimb")
