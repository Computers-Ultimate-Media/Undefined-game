extends "res://Inventory/Scripts/Controls/InventoryControl.gd"

var heads = []

func _ready():
	var dict_heads = read_from_JSON("res://Assets/JSON/Player/Head/player_heads.json")
	for key in dict_heads.keys():
		var head = load("res://Player/Head.tscn").instance()
		head.texture = load(dict_heads[key]["texture"])
		head.hpMax = dict_heads[key]["hpMax"]

		head.name = key

		heads.append(head)

	for i in range(0, heads.size()):
		var item = ItemFuck.instance()
		item.init(heads[i])
		var new_slot = grid_slots[i]
		new_slot.putIntoSlot(item)

func changeSelectedElement(element):
	player.head = element

func setPlayer(new_player):
	.setPlayer(new_player)
	var item = ItemFuck.instance()
	item.init(new_player.head)
	selectedSlot.putIntoSlot(item)
