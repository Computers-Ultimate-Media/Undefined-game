extends "res://Inventory/Scripts/Controls/InventoryControl.gd"

var heads = []
var selectedHead = null

func _ready():
	var dict_heads = read_from_JSON("res://Assets/JSON/Player/Head/player_heads.json")
	for key in dict_heads.keys():
		var head = load("res://Player/Head.tscn").instance()
		head.texture = load(dict_heads[key]["texture"])
		head.hpMax = dict_heads[key]["hpMax"]

		head.name = key

		heads.append(head)
