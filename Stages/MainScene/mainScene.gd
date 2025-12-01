extends Control

var hovering: bool = false
var button_type = null
const sandbox = preload(Global.GAME_SCENES.sandbox)
@onready var fade_timer = $FadeTransition/FadeTimer

var cursor1
var cursor2
#Input.set_custom_mouse_cursor(cursor1)

func _ready() -> void:
	fade_timer.wait_time = 1.0
	pass

func _on_start_pressed() -> void:
	button_type = "start"
	$FadeTransition.show()
	fade_timer.start()
	$FadeTransition/AnimationPlayer.play("fade_in")

func _on_exit_pressed() -> void:
	button_type = "exit"
	$FadeTransition.show()
	fade_timer.start()
	$FadeTransition/AnimationPlayer.play("fade_in")
	
	
func _on_fade_timer_timeout() -> void:
	if button_type == "start":
		get_tree().change_scene_to_packed(sandbox)
		pass
	if button_type == "exit":
		get_tree().quit()
