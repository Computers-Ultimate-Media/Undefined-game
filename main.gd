extends Node2D

var player
var timer

func _ready():
	player = $Player
	timer = $RegenTimer
	
	timer.wait_time = 10 - player.getPerkLVL()
	timer.start()

func _process(delta):
	$HUD.update_hp(player.hpMax, player.hpCurrent)


func _on_RegenTimer_timeout():
	if(player.hpCurrent < player.hpMax):
		player.hpCurrent += player.hpRegen
