extends Control

const mainScene = preload(Global.GAME_SCENES.mainScene)

func _input(event):
	if event.is_pressed():
		get_tree().change_scene_to_packed(mainScene)
