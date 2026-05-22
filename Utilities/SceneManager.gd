# SceneManager.gd (autoload)
extends Node

var current_scene: Node = null
var loading_path: String = ""
var fade_overlay: ColorRect

signal transition_complete

func _ready():
	fade_overlay = ColorRect.new()
	fade_overlay.color = Color.BLACK
	fade_overlay.color.a = 0.0
	fade_overlay.set_anchors_preset(Control.PRESET_FULL_RECT)
	fade_overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE
	fade_overlay.z_index = 100
	get_tree().root.call_deferred("add_child", fade_overlay)

func transition_to(path: String, entry_point: String = "default"):
	loading_path = path
	# Start background load immediately
	ResourceLoader.load_threaded_request(path)
	# Fade out
	var tween = create_tween()
	tween.tween_property(fade_overlay, "color:a", 1.0, 0.4)
	tween.tween_callback(_swap_scene.bind(path, entry_point))

func _swap_scene(path: String, entry_point: String):
	# Wait for load to finish (usually already done by now)
	while ResourceLoader.load_threaded_get_status(path) != ResourceLoader.THREAD_LOAD_LOADED:
		await get_tree().process_frame
	
	var new_scene = ResourceLoader.load_threaded_get(path).instantiate()
	
	if current_scene:
		current_scene.queue_free()
	
	get_tree().root.add_child(new_scene)
	current_scene = new_scene
	
	# Position player at entry point
	if new_scene.has_node("EntryPoints/" + entry_point):
		var player = get_tree().get_first_node_in_group("player")
		if player:
			player.global_position = new_scene.get_node("EntryPoints/" + entry_point).global_position
	
	# Fade in
	var tween = create_tween()
	tween.tween_property(fade_overlay, "color:a", 0.0, 0.4)
	tween.tween_callback(func(): transition_complete.emit())
