extends Node

signal quest_started(id)
signal quest_advanced(id)
signal quest_completed(id)
signal inventory_changed
signal toast(text)

var respawn_position: Vector2 = Vector2.ZERO
var respawn_scene: String = ""

const GAME_SCENES: Dictionary = {
	"player": "uid://brles2brqiwmx",
	"sandbox": "uid://c80maj2vdho5i",
	"mainScene": "uid://dn0d1brp825vr",
	"Cave": "uid://c04it1lgwtnka",
	"PauseMenu": "uid://cadg2taeq3c3a",
	"DeadScreen": "uid://bptiq5u0gd20a",
	"verdant_veins": "uid://c0x3l00ch074y"
}

var quest_db := {
	"escape": {
		"title": "Escape the Verdant Veins",
		"steps": [
			"Find the way out of the ruins",
			"The gate is sealed — find a way to open it",
		],
	},
	"the_key": {
		"title": "A Key of Old Parts",
		"steps": [
			"Gather 3 core fragments",
			"Open the Gate",
		],
	},
	"the_core": {
	"title": "The Dying Core",
	"steps": ["Reach the core chamber"],
	},
}

var souls = 0
var fragments = 0
var player: Node2D

var hp: int = 5:
	set(value):
		hp = clamp(value, 0, max_hp)
		hp_changed.emit(hp)
var max_hp: int = 5
signal hp_changed(new_hp: int)

func call_current_state(current_state):
	print(current_state)
	
var quests := {}   # id -> { "step": int, "done": bool }
var items := {}    # item_id -> count

func start_quest(id: String) -> void:
	if quests.has(id): return
	quests[id] = { "step": 0, "done": false }
	quest_started.emit(id)

func advance_quest(id: String) -> void:
	if not quests.has(id) or quests[id]["done"]: return
	var q = quests[id]
	var last = quest_db[id]["steps"].size() - 1
	if q["step"] < last:
		q["step"] += 1
		quest_advanced.emit(id)
	else:
		q["done"] = true
		quest_completed.emit(id)

func is_active(id: String) -> bool:
	return quests.has(id) and not quests[id]["done"]

func is_done(id: String) -> bool:
	return quests.has(id) and quests[id]["done"]

func current_step_text(id: String) -> String:
	return quest_db[id]["steps"][quests[id]["step"]]

func add_item(id: String, n := 1) -> void:
	items[id] = items.get(id, 0) + n
	inventory_changed.emit()

func remove_item(id: String, n := 1) -> void:
	items[id] = max(0, items.get(id, 0) - n)
	if items[id] == 0: items.erase(id)
	inventory_changed.emit()

func count(id: String) -> int:
	return items.get(id, 0)

func has_item(id: String) -> bool:
	return count(id) > 0

func show_toast(text: String) -> void:
	toast.emit(text)
	
	
