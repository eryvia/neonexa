extends Node

var master_volume: float = 1.0
var music_volume: float = 0.8
var sfx_volume: float = 1.0
var fullscreen: bool = false
var resolution_index: int = 2
var show_fps: bool = false

const SAVE_PATH = "user://settings.cfg"

const RESOLUTIONS = [
	Vector2i(1280, 720),
	Vector2i(1600, 900),
	Vector2i(1920, 1080),
	Vector2i(2560, 1440)
]

func _ready():
	load_settings()
	apply_settings()

func apply_settings():
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Master"),
		linear_to_db(master_volume)
	)
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Music"),
		linear_to_db(music_volume)
	)
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("SFX"),
		linear_to_db(sfx_volume)
	)
	
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	var res = RESOLUTIONS[resolution_index]
	DisplayServer.window_set_size(res)

func save_settings():
	var config = ConfigFile.new()
	config.set_value("audio", "master", master_volume)
	config.set_value("audio", "music", music_volume)
	config.set_value("audio", "sfx", sfx_volume)
	config.set_value("video", "fullscreen", fullscreen)
	config.set_value("video", "resolution", resolution_index)
	config.set_value("gameplay", "show_fps", show_fps)
	config.save(SAVE_PATH)

func load_settings():
	var config = ConfigFile.new()
	if config.load(SAVE_PATH) != OK:
		return  
	
	master_volume = config.get_value("audio", "master", 1.0)
	music_volume = config.get_value("audio", "music", 0.8)
	sfx_volume = config.get_value("audio", "sfx", 1.0)
	fullscreen = config.get_value("video", "fullscreen", false)
	resolution_index = config.get_value("video", "resolution", 2)
	show_fps = config.get_value("gameplay", "show_fps", false)
