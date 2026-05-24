extends CanvasLayer

@onready var panel: Control = $Panel
@onready var quest_list: VBoxContainer = $Panel/QuestList
@onready var item_list: VBoxContainer = $Panel/ItemList
@onready var Sprite: Sprite2D = $Panel/Sprite2D

func _ready() -> void:
	panel.visible = false
	Sprite.visible = false
	Global.quest_started.connect(_refresh)
	Global.quest_advanced.connect(_refresh)
	Global.quest_completed.connect(_refresh)
	Global.inventory_changed.connect(_refresh)

func _unhandled_input(e: InputEvent) -> void:
	if e.is_action_pressed("toggle_inventory"):
		panel.visible = not panel.visible
		Sprite.visible = not Sprite.visible
		if panel.visible:
			_refresh()

func _refresh(_a = null) -> void:
	for c in quest_list.get_children(): c.free() 
	for c in item_list.get_children(): c.free()
	for id in Global.quests:
		var l := Label.new()
		if Global.is_done(id):
			l.text = "✓ " + Global.quest_db[id]["title"]
			l.modulate = Color(0.5, 0.5, 0.5)
		else:
			l.text = "%s\n   → %s" % [Global.quest_db[id]["title"], Global.current_step_text(id)]
		quest_list.add_child(l)

	for c in item_list.get_children(): c.queue_free()
	if Global.items.is_empty():
		var e := Label.new(); e.text = "(empty)"; item_list.add_child(e)
	else:
		for item_id in Global.items:
			var l := Label.new()
			l.text = "%s  ×%d" % [item_id.capitalize().replace("_", " "), Global.items[item_id]]
			item_list.add_child(l)
