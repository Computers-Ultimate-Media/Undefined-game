extends "res://Inventory/Scripts/Controls/InventoryControl.gd"

func _ready():
	var weapons = Weapon.fromJsonArray("res://Assets/JSON/Player/Weapon/player_weapons.json")

	for i in range(0, weapons.size()):
		var item = Item.instance()
		item.init(weapons[i])
		var new_slot = grid_slots[i]
		new_slot.putIntoSlot(item)

func changeSelectedElement(element):
	player.weapon = element

func setPlayer(new_player):
	.setPlayer(new_player)
	var item = Item.instance()
	item.init(new_player.weapon)
	selectedSlot.putIntoSlot(item)
