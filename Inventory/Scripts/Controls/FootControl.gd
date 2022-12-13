extends "res://Inventory/Scripts/Controls/InventoryControl.gd"

var feet = []

func _ready():
	var dict_feet = read_from_JSON("res://Assets/JSON/Player/Foot/player_feet.json")
	for key in dict_feet.keys():
		var foot = load("res://Player/Foot.tscn").instance()
		foot.texture = load(dict_feet[key]["texture"])
		foot.moveSpeed = dict_feet[key]["moveSpeed"]

		foot.name = key

		feet.append(foot)

	for i in range(0, feet.size()):
		var item = Item.instance()
		item.init(feet[i])
		var new_slot = grid_slots[i]
		new_slot.putNewIntoSlot(item)

func changeSelectedElement(element):
	player.foot = element

func setPlayer(new_player):
	.setPlayer(new_player)
	var item = Item.instance()
	item.init(new_player.foot)
	selectedSlot.putNewIntoSlot(item)
