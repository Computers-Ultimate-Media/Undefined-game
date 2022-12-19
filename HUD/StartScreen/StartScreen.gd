extends CanvasLayer

var fullscreen: bool
var sound_value: int
var framerate: int

onready var vp = get_tree().get_root()
onready var base_size = Vector2(1920, 1080)

func _ready():
	set_windowed()
	$AnimatedSprite/AnimationPlayer.play("background")
	$BackSound.play()
	
	var dict_settings = read_from_JSON("res://Assets/JSON/Game settings/settings.json")
	
	fullscreen = dict_settings["fullscreen"]
	sound_value = dict_settings["sound_value"]
	framerate = dict_settings["framerate"]
	
	OS.window_fullscreen = fullscreen
	Engine.target_fps = framerate

func set_windowed():
	var window_size = OS.get_screen_size()
	var scale = min(window_size.x / base_size.x, window_size.y / base_size.y)
	var scaled_size = (base_size * scale).round()
	
	var window_x = (window_size.x / 2) - (scaled_size.x / 2)
	var window_y = (window_size.y / 2) - (scaled_size.y / 2)
	OS.set_borderless_window(false)
	OS.set_window_fullscreen(false)
	OS.set_window_position(Vector2(window_x, window_y))
	OS.set_window_size(scaled_size)
	vp.set_size(scaled_size)

func read_from_JSON(path):
	var file = File.new()
	if file.file_exists(path):
		file.open(path, File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		return data
	else:
		printerr("Invalid path given")
