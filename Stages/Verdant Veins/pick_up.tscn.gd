extends Area2D

@export var item_id: String = "core_fragment"

func _ready() -> void:
	body_entered.connect(_on_body)

func _on_body(b: Node2D) -> void:
	if not b.is_in_group("player"): return
	Global.add_item(item_id)
	if Global.is_active("the_key") and Global.quests["the_key"]["step"] == 0:
		if Global.count("core_fragment") >= 3:
			Global.advance_quest("the_key")  # -> "bring them to the Keeper"
	queue_free()
