extends Node2D

@export var is_starting_room: bool = false
@export var start_door_id: String = "start"

func _ready():
	SceneManager.register_room(self)
	if is_starting_room:
		SceneManager.place_player_at_start(self, start_door_id)
