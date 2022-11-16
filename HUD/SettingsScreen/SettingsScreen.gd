extends CanvasLayer

var path = "res://Assets/JSON/Game settings/settings.json"
var sound_value: int
var framerate: int
var fullscreen: bool
var language = "ru"

var settings_dict = {
	"fullscreen": fullscreen,
	"sound_value": sound_value,
	"framerate": framerate,
	"language": language
}

func _ready():
	settings_dict = read_from_JSON("res://Assets/JSON/Game settings/settings.json")
	
	$FullscreenCheck.pressed = settings_dict["fullscreen"]
	$FpsScroll.value = settings_dict["framerate"]
	$SoundScroll.value = settings_dict["sound_value"]

func _on_ExitButton_pressed():
	get_tree().change_scene("res://HUD/StartScreen/StartScreen.tscn")
	settings_dict["fullscreen"] = $FullscreenCheck.pressed
	settings_dict["sound_value"] = sound_value
	settings_dict["framerate"] = framerate
	
	_save_to_JSON(settings_dict, path)
	
	Engine.target_fps = framerate
	OS.window_fullscreen = fullscreen
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), sound_value)

func _save_to_JSON(dict, path):
		var file = File.new()
		if file.file_exists(path):
			file.open(path, File.WRITE)
			file.store_string(JSON.print(dict, "\t")) 
			file.close()
		else:
			printerr("Invalid path given")

func read_from_JSON(path):
	var file = File.new()
	if file.file_exists(path):
		file.open(path, File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		return data
	else:
		printerr("Invalid path given")

func _on_FpsScroll_value_changed(value):
	$FpsScroll/Value.text = str(value) 
	framerate = value

func _on_FullscreenCheck_toggled(button_pressed):
	fullscreen = button_pressed

func _on_SoundScroll_value_changed(value):
	$SoundScroll/Value.text = str(value) 
	sound_value = value
