extends Panel
class_name Slot

var ItemClass = preload("res://Inventory/Item.tscn")
var item = null

func _ready():
	self.connect("gui_input", self, "_on_Player_select_slot")
	if randi() % 2 == 0:
		item = ItemClass.instance()
		add_child(item)
		
func _on_Player_select_slot(event):
	if(event is InputEventMouseButton):
		if(event.button_index == BUTTON_LEFT and not event.pressed):
			print(self)

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
