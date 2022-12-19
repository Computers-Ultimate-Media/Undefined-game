extends Node
class_name Utils

static func read_from_JSON(path: String) -> Dictionary:
	var file = File.new()
	if file.file_exists(path):
		file.open(path, File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		return data
	else:
		printerr("Invalid path given")
		return {}


static func save_to_JSON(dict: Dictionary, path: String):
	var file = File.new()
	if file.file_exists(path):
		file.open(path, File.WRITE)
		file.store_string(JSON.print(dict, "\t"))
		file.close()
	else:
		printerr("Invalid path given")
