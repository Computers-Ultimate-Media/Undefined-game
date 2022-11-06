extends KinematicBody2D

class_name Enemy

var Player

export var speed = 1000
var velocity : Vector2
var last_direction = Vector2(0, 1)
var bounce_countdown = 0

export var health = 100
export var max_health = 100
export var damage = 10

signal enemy_dead;
signal enemy_hit;

onready var health_bar = $HeathBar

func _ready():
	health_bar._on_max_health_updated(max_health)
	Player = get_tree().root.get_node("main/Player")
	
func _process(delta):
	pass

func _physics_process(delta):
	var player_relative_position =  Player.position - global_position 
	velocity = player_relative_position.normalized()
	var movement = velocity * speed * delta
	move_and_slide(movement)

func hit(damage):
	health -= damage
	emit_signal("enemy_hit")
	health_bar._display_health_bar(true)

func death():
	self.queue_free()
	emit_signal("enemy_dead")

func _on_Enemy_enemy_dead():
	Player.setCoins(Player.getCoins() + 10)

func _on_Enemy_enemy_hit():
	health_bar._on_health_updated(health, 0)
