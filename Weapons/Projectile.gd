extends Node2D

class_name Projectile

var weapon_owner setget set_weapon_owner
var direction := Vector2(-1, 0) setget set_direction

var damage: int
var time: int
var speed: int

onready var timer = $KillTimer

func _ready():
	timer.start(time / 3)
	
func attack(target):
	target.hit(damage)
	queue_free()
	if(target.health <= 0):
		target.death()
	
func _process(delta):
	if direction != Vector2.ZERO:
		var velocity = direction * speed
		global_position += velocity

func set_direction(vector: Vector2):
	direction = vector
	rotation += direction.angle()

func _on_KillTimer_timeout():
	queue_free()

func set_weapon_owner(value):
	weapon_owner = value

func _on_Projectile_body_entered(body):
	if body.name == "TileMap_walls" \
	or body.name == "StaticBody2D":
		queue_free()
	else:
		if !body.name.begins_with(weapon_owner):
			attack(body)
