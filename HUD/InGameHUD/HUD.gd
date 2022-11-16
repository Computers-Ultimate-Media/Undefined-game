extends CanvasLayer

func _on_Player_player_stats_changed(player):
	$HP/Label.text = str(player.getHpCurrent()) + "/" + str(player.getHpMax())
	$Armor/Label.text = str(player.getArmorCurrent()) + "/" + str(player.getArmorMax())
	$Coin/Label.text = str(player.getCoins())
	
func _on_Player_player_dead():
	get_tree().paused = true
	$GameOver.visible = true
	
	$HP.visible = false
	$Armor.visible = false
	$Coin.visible = false
