extends "res://Inventory/Scripts/Controls/InventoryControl.gd"

var bodies = []

func _ready():
	var dict_bodies = read_from_JSON("res://Assets/JSON/Player/Body/player_bodies.json")
	for key in dict_bodies.keys():
		var body = load("res://Player/Body.tscn").instance()
		body.texture = load(dict_bodies[key]["texture"])
		body.hpBody = dict_bodies[key]["hpBody"]
		body.hpRegen = dict_bodies[key]["hpRegen"]
		
		body.name = key
		
		bodies.append(body)

	for i in range(0, bodies.size()):
		var item = Item.instance()
		item.init(bodies[i])
		var new_slot = grid_slots[i]
		new_slot.putNewIntoSlot(item)

func changeSelectedElement(element):
	player.body = element

func setPlayer(new_player):
	.setPlayer(new_player)
	var item = Item.instance()
	item.init(new_player.body)
	selectedSlot.putNewIntoSlot(item)
