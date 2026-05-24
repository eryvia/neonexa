extends Node

var _player: Node2D
var _current_room: Node = null
var _fade: ColorRect
var _is_transitioning: bool = false

const PLAYER_SCENE := "res://Entities/Player/Player.tscn"

func _ready():
	# Fade overlay on its own CanvasLayer so it always covers everything
	var layer := CanvasLayer.new()
	layer.layer = 128
	add_child(layer)
	_fade = ColorRect.new()
	_fade.color = Color(0, 0, 0, 0)
	_fade.set_anchors_preset(Control.PRESET_FULL_RECT)
	_fade.mouse_filter = Control.MOUSE_FILTER_IGNORE
	layer.add_child(_fade)

	# Persistent player — spawned once, survives all transitions
	_player = load(PLAYER_SCENE).instantiate()
	add_child(_player)

func get_player() -> Node2D:
	return _player

# Every room calls this in its _ready()
func register_room(room: Node):
	_current_room = room

# The starting room calls this to place the player on first load
func place_player_at_start(room: Node, door_id: String):
	var door := _find_door(room, door_id)
	if door:
		_player.global_position = door.get_spawn_position()
		door.disarm()
	else:
		push_warning("Start door not found: " + door_id)

func clear_player():
	if is_instance_valid(_player):
		_player.queue_free()
		_player = null

# Called by a Door when the player walks through it
func use_door(target_scene: String, target_door_id: String):
	if _is_transitioning:
		return
	_is_transitioning = true

	_player.set_physics_process(false)
	_player.set_process_input(false)

	ResourceLoader.load_threaded_request(target_scene)

	# Fade out
	var t := create_tween()
	t.tween_property(_fade, "color:a", 1.0, 0.4)
	await t.finished

	# Wait for the scene to finish loading
	while ResourceLoader.load_threaded_get_status(target_scene) \
			!= ResourceLoader.THREAD_LOAD_LOADED:
		await get_tree().process_frame

	# Remove old room, wait until it's truly gone
	if is_instance_valid(_current_room):
		var dying := _current_room
		dying.queue_free()
		await dying.tree_exited

	# Add new room
	var packed: PackedScene = ResourceLoader.load_threaded_get(target_scene)
	var new_room: Node = packed.instantiate()
	get_tree().root.add_child(new_room)
	_current_room = new_room

	# Place player at the matching door
	var door := _find_door(new_room, target_door_id)
	if door:
		_player.global_position = door.get_spawn_position()
		door.disarm()
	else:
		push_warning("Target door not found: " + target_door_id)

	_player.set_physics_process(true)
	_player.set_process_input(true)

	# Fade in
	var t2 := create_tween()
	t2.tween_property(_fade, "color:a", 0.0, 0.4)
	await t2.finished

	_is_transitioning = false

func _find_door(room: Node, door_id: String) -> Node:
	for d in get_tree().get_nodes_in_group("doors"):
		if d.is_inside_tree() and room.is_ancestor_of(d) \
				and d.get_door_id() == door_id:
			return d
	return null
