extends Node2D

var Player
var timer
# Called when the node enters the scene tree for the first time.
func _ready():
	Player = get_node("Player")
	timer = get_node("RegenTimer")
	timer.wait_time = 10 - Player.getPerkLVL()
	
	$RegenTimer.start()

func _process(delta):
	$HUD.update_hp(Player.getMaxHP(), Player.getCurrentHP())


func _on_RegenTimer_timeout():
	Player.regenerate()
