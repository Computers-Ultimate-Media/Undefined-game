extends Node

onready var grid_slots = self.get_children()
var holding_item = null

func _ready():
	var selectedSlot = self.get_parent().get_child(1)
	grid_slots.append(selectedSlot)
	for slot in grid_slots:
		slot.connect("gui_input", self, "slot_gui_input", [slot])

func slot_gui_input(event: InputEvent, slot: Slot):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			if (holding_item != null):
				if !slot.item: # place holding item to slot
					# emit_signal()
					slot.putIntoSlot(holding_item)
					holding_item = null
				else: # swap holding item with item in slot
					var temp_item = slot.item
					slot.pickFromSlot()
					temp_item.global_position = event.global_position
					slot.putIntoSlot(holding_item)
					holding_item = temp_item
			elif slot.item:
				holding_item = slot.item
				slot.pickFromSlot()
				_input(event)

func _input(event):
	if holding_item:
		var global_mouse_position = holding_item.get_global_mouse_position()
		global_mouse_position.x += 1
		global_mouse_position.y += 1
		holding_item.global_position = global_mouse_position
