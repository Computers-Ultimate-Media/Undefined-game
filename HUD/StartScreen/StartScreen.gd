extends CanvasLayer

var fullscreen: bool
var sound_value: int
var framerate: int

func _ready():
	var dict_settings = Utils.read_from_JSON("res://Assets/JSON/Game settings/settings.json")
	
	fullscreen = dict_settings["fullscreen"]
	sound_value = dict_settings["sound_value"]
	framerate = dict_settings["framerate"]
	
	OS.window_fullscreen = fullscreen
	Engine.target_fps = framerate