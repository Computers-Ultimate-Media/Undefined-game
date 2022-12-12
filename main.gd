extends Node2D

var player
var timer

func _ready():
	player = $Player
	timer = $RegenTimer
	
	timer.wait_time = 10
	timer.start()


func _on_RegenTimer_timeout():
#	var head = load("res://Player/Head.tscn").instance()
#	head.texture = load("res://Assets/Player/Body/cat.png")
#	head.hpMax = 562
#	head.name = "Head" 
#
#	player.head = head
	
#	var body = load("res://Player/Body.tscn").instance()
#	body.texture = load("res://Assets/Player/Body/cat.png")
#	body.hpBody = 12
#	body.hpRegen = 123
#	body.name = "Body" 
#
#	player.body = body
#
	pass
