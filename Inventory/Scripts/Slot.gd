extends PanelContainer
class_name Slot

onready var inventoryNode = find_parent("Inventory")
var item = null

func pickFromSlot():
	remove_child(item)
	inventoryNode.add_child(item)
	item = null

func putIntoSlot(new_item):
	item = new_item
	item.position = Vector2(0, 0)
	if inventoryNode.has_node(new_item.name):
		inventoryNode.remove_child(item)
	add_child(item)
