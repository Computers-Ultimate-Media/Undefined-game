extends CanvasLayer

var current_player = null

func _on_Player_open_inventory(player):
	if not current_player:
		current_player = player
		($HeadControl).player = player
		($BodyControl).player = player
		($FootControl).player = player
		($WeaponControl).player = player

	self.visible = !(self.visible)
