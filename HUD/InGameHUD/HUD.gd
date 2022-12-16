extends CanvasLayer

func _on_Player_player_stats_changed(player):
	$HP/Label.text = str(player.health) + "/" + str(player.healthMax)
	$Armor/Label.text = str(player.armor) + "/" + str(player.armorMax)
	$Coin/Label.text = str(player.coins)
	$Regen/Label.text = str(player.hpRegen)
	$MoveSpeed/Label.text = str(player.moveSpeed)

	
func _on_Player_player_dead():
	get_tree().paused = true
	$GameOver.visible = true
	$HP.visible = false
	$Armor.visible = false
	$Coin.visible = false
	$Regen.visible= false
	$MoveSpeed.visible = false
