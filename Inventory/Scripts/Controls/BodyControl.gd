extends "res://Inventory/Scripts/Controls/InventoryControl.gd"

var bodies = []
var selectedBody = null

func _ready():
	var dict_bodies = read_from_JSON("res://Assets/JSON/Player/Body/player_bodies.json")
	for key in dict_bodies.keys():
		var body = load("res://Player/Body.tscn").instance()
		body.texture = load(dict_bodies[key]["texture"])
		body.hpBody = dict_bodies[key]["hpBody"]
		body.hpRegen = dict_bodies[key]["hpRegen"]
		
		body.name = key
		
		bodies.append(body)

func changeSelectedElement(element):
	selectedBody = element
	player.body = element


