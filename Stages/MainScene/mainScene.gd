extends Control

var hovering: bool = false
var button_type = null
const Prologue = preload(Global.GAME_SCENES.verdant_veins)
@onready var fade_timer = $FadeTransition/FadeTimer
@onready var menu_items := $MainVBox.get_children()
@onready var mini_axo := $AnimatedSprite2D
var selected_index := 0

var cursor1
var cursor2d
#Input.set_custom_mouse_cursor(cursor1)

func _ready() -> void:
	SceneManager.clear_player()
	update_menu()
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

func _unhandled_input(event):
	if event.is_action_pressed("ui_down"):
		selected_index += 1
		if selected_index >= menu_items.size():
			selected_index = 0
		update_menu()

	elif event.is_action_pressed("ui_up"):
		selected_index -= 1
		if selected_index < 0:
			selected_index = menu_items.size() - 1
		update_menu()

	elif event.is_action_pressed("ui_accept"):
		activate_selected()

func update_menu():
	for i in range(menu_items.size()):
		if i == selected_index:
			menu_items[i].modulate = Color(1, 1, 0)

			mini_axo.global_position.y = menu_items[i].global_position.y + 6
			mini_axo.global_position.x = menu_items[i].global_position.x - 10
			
			if mini_axo.is_playing():
				mini_axo.stop()
			
			mini_axo.play("default")
		else:
			menu_items[i].modulate = Color(1, 1, 1)

func _on_fade_timer_timeout() -> void:
	if button_type == "start":
		get_tree().change_scene_to_packed(Prologue)
		pass
	if button_type == "exit":
		get_tree().quit()

func activate_selected():
	match selected_index:
		0:
			button_type = "start"
			$FadeTransition.show()
			fade_timer.start()
			$FadeTransition/AnimationPlayer.play("fade_in")
		1:
			print("Options")
		2:
			button_type = "exit"
			$FadeTransition.show()
			fade_timer.start()
			$FadeTransition/AnimationPlayer.play("fade_in")
			
