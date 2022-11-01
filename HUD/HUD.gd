extends CanvasLayer

func _ready():
	pass # Replace with function body.


func update(player: KinematicBody2D):
	$HP/Label.text = str(player.getHpCurrent()) + "/" + str(player.getHpMax())
	$Armor/Label.text = str(player.getHpBody())
	$Coin/Label.text = str(player.getCoins())
