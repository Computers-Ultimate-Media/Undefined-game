extends "res://Inventory/Scripts/Slot.gd"
class_name SelectedSlot

onready var inventoryControl = get_parent()

func pickFromSlot():
	inventoryControl.changeSelectedElement(null)
	.pickFromSlot()

func putIntoSlot(new_item):
	inventoryControl.changeSelectedElement(new_item.element)
	.putIntoSlot(new_item)
