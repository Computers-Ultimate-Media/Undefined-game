extends CanvasLayer

func _on_Player_player_stats_changed(player):
	$HP/Label.text = str(player.health) + "/" + str(player.healthMax)
	$Armor/Label.text = str(player.armor) + "/" + str(player.armorMax)
	$Coin/Label.text = str(player.coins)
