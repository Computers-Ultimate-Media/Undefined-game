extends "res://Inventory/Scripts/Controls/InventoryControl.gd"

func _ready():
	var bodies = Body.fromArray(player_items["bodies"])
	for i in range(0, bodies.size()):
		var item = Item.instance()
		item.init(bodies[i])
		var new_slot = grid_slots[i]
		new_slot.putIntoSlot(item)

func changeSelectedElement(element):
	player.body = element

func setPlayer(new_player):
	.setPlayer(new_player)
	var item = Item.instance()
	item.init(new_player.body)
	selectedSlot.putIntoSlot(item)
