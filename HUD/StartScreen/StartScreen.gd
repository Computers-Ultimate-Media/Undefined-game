extends CanvasLayer

var fullscreen: bool
var sound_value: int
var framerate: int

func _ready():
	var dict_settings = read_from_JSON("res://Assets/JSON/Game settings/settings.json")
	
	fullscreen = dict_settings["fullscreen"]
	sound_value = dict_settings["sound_value"]
	framerate = dict_settings["framerate"]
	
	OS.window_fullscreen = fullscreen
	Engine.target_fps = framerate


func read_from_JSON(path):
	var file = File.new()
	if file.file_exists(path):
		file.open(path, File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		return data
	else:
		printerr("Invalid path given")
