extends CanvasLayer

var player = null

func _on_Player_open_inventory(player):
	if not self.player:
		self.player = player
		($HeadControl).player = player
		($BodyControl).player = player
		($FootControl).player = player

	self.visible = !(self.visible)
