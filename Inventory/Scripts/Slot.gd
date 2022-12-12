extends Panel
class_name Slot

const ItemFuck = preload("res://Inventory/Item.gd")

var item : ItemFuck = null

func pickFromSlot():
	remove_child(item)
	var inventoryNode = find_parent("Inventory")
	inventoryNode.add_child(item)
	item = null

func putIntoSlot(new_item):
	item = new_item
	item.position = Vector2(0, 0)
	var inventoryNode = find_parent("Inventory")
	inventoryNode.remove_child(item)
	add_child(item)
