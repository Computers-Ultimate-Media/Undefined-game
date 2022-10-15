extends KinematicBody2D

var Player

export var speed = 1000
var velocity : Vector2
var last_direction = Vector2(0, 1)
var bounce_countdown = 0

signal enemy_dead;


func _process(delta):
	pass

func _physics_process(delta):
	Player = get_tree().root.get_node("main/Player")
	var player_relative_position =  Player.position - global_position 
	velocity = player_relative_position.normalized()
	var movement = velocity * speed * delta
	move_and_slide(movement)

func death():
	emit_signal("enemy_dead")
	pass

		
func _ready():
	pass
