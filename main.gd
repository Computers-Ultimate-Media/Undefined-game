extends Node2D

var player
var timer

func _ready():
	player = $Player
	timer = $RegenTimer
	
	timer.wait_time = 10
	timer.start()
