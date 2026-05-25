extends Node2D
@onready var interaction_area: InteractiveArea = $InteractiveArea
@onready var animS = $AnimatedSprite2D
const lines: Array[String] = [
	"..",
	"...",
	"You cant talk... seems sad for a soul like yours",
	"...!",
	"you... you carry the kings brand",
	"you really were abonded",
	"like me, heh?",
	"tell you what",
	"if you can get me my legs",
	"I shall reward you kindly."
]
func _ready():
	interaction_area.interact = _on_interact
func _on_interact():
	DialogueManager.start_dialog(global_position, lines)
	var player = get_tree().get_first_node_in_group("player")
	if player:
		animS.flip_h = player.global_position.x > global_position.x
	while DialogueManager.is_dialog_active:
		await get_tree().process_frame
	
