extends "res://Inventory/Scripts/Controls/InventoryControl.gd"

func _ready():
	var heads = Head.fromArray(player_items["heads"])
	for i in range(0, heads.size()):
		var item = Item.instance()
		item.init(heads[i])
		var new_slot = grid_slots[i]
		new_slot.putIntoSlot(item)

func changeSelectedElement(element):
	player.head = element

func setPlayer(new_player):
	.setPlayer(new_player)
	var item = Item.instance()
	item.init(new_player.head)
	selectedSlot.putIntoSlot(item)
