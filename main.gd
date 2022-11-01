extends Node2D

onready var player = $Player
var bodies = []
var heads = []
var feet = []
var i = 0

func _ready():
	pass

#	var dict_heads = read_from_JSON("res://Assets/JSON/Player/Head/player_heads.json")
#	for key in dict_heads.keys():
#		var head = load("res://Player/Head.tscn").instance()
#		head.texture = load(dict_heads[key]["texture"])
#		head.hpMax = dict_heads[key]["hpMax"]
#
#		head.name = key
#
#		heads.append(head)
#
#	var dict_bodies = read_from_JSON("res://Assets/JSON/Player/Body/player_bodies.json")
#	for key in dict_bodies.keys():
#		var body = load("res://Player/Body.tscn").instance()
#		body.texture = load(dict_bodies[key]["texture"])
#		body.hpBody = dict_bodies[key]["hpBody"]
#		body.hpRegen = dict_bodies[key]["hpRegen"]
#
#		body.name = key
#
#		bodies.append(body)
#
#
#	var dict_feet = read_from_JSON("res://Assets/JSON/Player/Foot/player_feet.json")
#	for key in dict_feet.keys():
#		var foot = load("res://Player/Foot.tscn").instance()
#		foot.texture = load(dict_feet[key]["texture"])
#		foot.moveSpeed = dict_feet[key]["moveSpeed"]
#
#		foot.name = key
#
#		feet.append(foot)

func _process(delta):
	$HUD.update(player)

func read_from_JSON(path):
	var file = File.new()
	if file.file_exists(path):
		file.open(path, File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		return data
	else:
		printerr("Invalid path given")


