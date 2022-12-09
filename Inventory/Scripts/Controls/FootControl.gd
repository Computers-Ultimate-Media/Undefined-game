extends "res://Inventory/Scripts/Controls/InventoryControl.gd"

var feet = []
var selectedFoot = null

func _ready():
	var dict_feet = read_from_JSON("res://Assets/JSON/Player/Foot/player_feet.json")
	for key in dict_feet.keys():
		var foot = load("res://Player/Foot.tscn").instance()
		foot.texture = load(dict_feet[key]["texture"])
		foot.moveSpeed = dict_feet[key]["moveSpeed"]

		foot.name = key

		feet.append(foot)
