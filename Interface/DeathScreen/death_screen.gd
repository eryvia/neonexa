extends CanvasLayer
class_name DeadScreen

var player_ref: Node = null

func _ready():
	$Panel/VBox/Respawn.pressed.connect(_on_respawn)
	$Panel/VBox/MainMenu.pressed.connect(_on_main_menu)
	Engine.time_scale = 0.0
	$AudioStreamPlayer2D.play(3.0)

func _on_respawn():
	Global.hp = 5
	print(Global.hp)
	Engine.time_scale = 1.0
	queue_free()
	get_tree().reload_current_scene()
	

func _on_main_menu():
	Engine.time_scale = 1.0
	queue_free()
	get_tree().change_scene_to_file(Global.GAME_SCENES.mainScene)

static func open(parent: Node, player: Node = null):
	var scene = load(Global.GAME_SCENES.DeadScreen)
	var instance = scene.instantiate()
	instance.player_ref = player
	parent.add_child(instance)
