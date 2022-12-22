extends Control

const Item = preload("res://Inventory/Item.tscn")

var player = null setget setPlayer
var holding_item = null

onready var player_items = Utils.read_from_JSON("res://Assets/JSON/Player/player_items.json")

onready var gridContainer = self.get_child(0)
onready	var selectedSlot = self.get_child(1)
onready var grid_slots = gridContainer.get_children()

func _ready():
	grid_slots.append(selectedSlot)
	for slot in grid_slots:
		slot.connect("gui_input", self, "grid_slot_gui_input", [slot])

func _input(_event):
	if holding_item:
		var global_mouse_position = holding_item.get_global_mouse_position()
		global_mouse_position.x += 1
		global_mouse_position.y += 1
		holding_item.global_position = global_mouse_position

func setPlayer(new_player):
	player = new_player

func grid_slot_gui_input(event: InputEvent, slot: Slot):
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
