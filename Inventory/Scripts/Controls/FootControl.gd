extends "res://Inventory/Scripts/Controls/InventoryControl.gd"


func _ready():
	var feet = Foot.fromJsonArray("res://Assets/JSON/Player/Foot/player_feet.json")

	for i in range(0, feet.size()):
		var item = Item.instance()
		item.init(feet[i])
		var new_slot = grid_slots[i]
		new_slot.putIntoSlot(item)

func changeSelectedElement(element):
	player.foot = element

func setPlayer(new_player):
	.setPlayer(new_player)
	var item = Item.instance()
	item.init(new_player.foot)
	selectedSlot.putIntoSlot(item)
