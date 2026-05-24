extends Label  

func _ready() -> void:
	Global.quest_started.connect(_update)
	Global.quest_advanced.connect(_update)
	Global.quest_completed.connect(_update)
	_update()

func _update(_a = null) -> void:
	for id in Global.quests:
		if Global.is_active(id):
			text = "▸ " + Global.current_step_text(id)
			return
	text = ""
