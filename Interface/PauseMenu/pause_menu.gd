extends Control
class_name PauseMenu

var player_ref: Node

func _ready():
	get_tree().paused = true
	
	$Panel/VBox/ResumeBtn.pressed.connect(_on_resume)
	$Panel/VBox/SettingsBtn.pressed.connect(_on_settings)
	$Panel/VBox/QuitBtn.pressed.connect(_on_quit)
	
	$Overlay.gui_input.connect(func(event):
		if event is InputEventMouseButton and event.pressed:
			_on_resume()
	)
	
	modulate.a = 0
	$Panel.scale = Vector2(0.9, 0.9)
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.2)
	tween.parallel().tween_property($Panel, "scale", Vector2(1, 1), 0.2)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		_on_resume()

func _on_resume():
	if player_ref:
		player_ref.is_paused = false 
	get_tree().paused = false
	var tween = create_tween()
	tween.tween_property($Panel, "scale", Vector2(0.9, 0.9), 0.15)
	tween.parallel().tween_property(self, "modulate:a", 0.0, 0.15)
	tween.tween_callback(queue_free)


func _on_settings():
	pass
	#SettingsMenu.open(self)

func _on_quit():
	get_tree().paused = false
	get_tree().change_scene_to_file(Global.GAME_SCENES.mainScene) #mainscene

static func open(parent: Node, player: Node = null):
	var scene = load(Global.GAME_SCENES.PauseMenu)
	var instance = scene.instantiate()
	instance.player_ref = player
	parent.add_child(instance)
