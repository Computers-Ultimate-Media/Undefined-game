extends Node2D

class_name Bullet

var weapon_owner setget set_weapon_owner
var direction := Vector2.ZERO setget setDirection

var damage: int
var time: int
var speed: int

onready var timer = $KillTimer

func _ready():
	timer.start(time / 3)

func _physics_process(delta):
	if direction != Vector2.ZERO:
		var velocity = direction * speed
		global_position += velocity

func attack(target):
	target.hit(damage)
	queue_free()
	if(target.health <= 0):
		target.death()
	
func setDirection(newDirection: Vector2):
	direction = newDirection

func _on_KillTimer_timeout():
	queue_free()

func set_weapon_owner(value):
	weapon_owner = value

func _on_Bullet_body_entered(body):
	if body.name == "TileMap" \
	or body.name == "StaticBody2D":
		queue_free()
	else:
		if !body.name.begins_with(weapon_owner) && !body.name.begins_with("@"+weapon_owner) :
			attack(body)
