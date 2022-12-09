extends CanvasLayer

var ItemClass = preload("res://Inventory/Item.tscn")
var player = null

#signal pick_from_slot

func _on_Player_open_inventory(player):
	self.player = player

	($HeadControl).player = player
	($BodyControl).player = player
	($FootControl).player = player
#	($GunControl).player = player

	self.visible = !(self.visible)

#func _on_Player_pick_from_slot(slot: Slot, item: Item):
#	pass
