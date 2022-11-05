extends CanvasLayer

func _ready():
	pass # Replace with function body.

func _on_Player_player_stats_changed(player):
	$HP/Label.text = str(player.getHpCurrent()) + "/" + str(player.getHpMax())
	$Armor/Label.text = str(player.getArmorCurrent()) + "/" + str(player.getArmorMax())
	$Coin/Label.text = str(player.getCoins())
