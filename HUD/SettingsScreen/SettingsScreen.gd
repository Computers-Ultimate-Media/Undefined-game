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
	$CheckBox.pressed = settings_dict["fullscreen"]
	
func _on_CheckBox_toggled(button_pressed):
	OS.window_fullscreen = button_pressed
	
func _on_ExitButton_pressed():
	get_tree().change_scene("res://HUD/StartScreen/StartScreen.tscn")
	settings_dict["fullscreen"] = $CheckBox.pressed
	settings_dict["sound_value"] = sound_value
	settings_dict["framerate"] = framerate
	
	_save_to_JSON(settings_dict, path)
	
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
