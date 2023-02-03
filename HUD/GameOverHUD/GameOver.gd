extends CanvasLayer

func _on_Player_player_dead():
	get_tree().paused = true
	self.visible = true
	get_tree().root.get_node("main/HUD/HP").visible = false
	get_tree().root.get_node("main/HUD/Armor").visible = false
	get_tree().root.get_node("main/HUD/Coin").visible = false
	get_tree().root.get_node("main/Inventory").visible = false
	get_tree().root.get_node("main/SkilsMenu").visible = false
