extends Node2D

@export var anim: AnimatedSprite2D
@onready var interaction_area: InteractiveArea = $InteractiveArea

func _ready() -> void:
	interaction_area.action_name = "talk"
	interaction_area.interact = _on_interact

func _on_interact():
	var player = get_tree().get_first_node_in_group("player")

	# capture state BEFORE dialogue starts
	var was_fresh    := not Global.quests.has("the_key")
	var was_returning := Global.quests.has("the_key") \
	and not Global.is_done("the_key") \
	and Global.count("core_fragment") >= 3

	# pick lines
	var lines: Array[String] = _get_lines()
	if lines.is_empty(): return

	# same pattern as your working NPC — start first, then await
	DialogueManager.start_dialog(global_position, lines)
	if player and anim:
		anim.flip_h = player.global_position.x > global_position.x
	while DialogueManager.is_dialog_active:
		await get_tree().process_frame

	# state changes AFTER dialogue finishes
	if was_fresh:
		Global.start_quest("the_key")
		if Global.is_active("escape") and Global.quests["escape"]["step"] == 0:
			Global.advance_quest("escape")
	elif was_returning:
		Global.remove_item("core_fragment", 3)
		Global.add_item("rusty_key")
		Global.advance_quest("the_key")
		
func _get_lines() -> Array[String]:
	if not Global.quests.has("the_key"):
		return [
			"The gate ahead has been sealed for a long time.",
			"I can forge a key — but I need materials.",
			"Bring me 3 core fragments. They're scattered through the ruins.",
		]
	elif Global.is_done("the_key"):
		return ["Go. The way is open."]
	elif Global.count("core_fragment") >= 3:  # has all, regardless of step
		return [
			"You found them all.",
			"...",
			"Here. The gate will open for you now.",
		]
	else:
		var have := Global.count("core_fragment")
		return ["I still need %d more fragment%s." % [3 - have, "s" if (3 - have) > 1 else ""]]
		
		
"""
extends Node2D
@onready var interaction_area: InteractiveArea = $InteractiveArea
@onready var animS = $AnimatedSprite2D
const lines: Array[String] = [
    "Hello..",
    "So you finally decided to stand up",
    "So...",
    "You dont remember do you?",
    "Well, that isnt necessery a bad thing",
    "I hope you find peace then.",
]
func _ready():
    interaction_area.interact = _on_interact
func _on_interact():
    DialogueManager.start_dialog(global_position, lines)
    var player = get_tree().get_first_node_in_group("player")
    if player:
        animS.flip_h = player.global_position.x > global_position.x
    while DialogueManager.is_dialog_active:
        await get_tree().process_frame"
"""
