extends Node2D

class_name Projectile

var weapon_owner setget set_weapon_owner
var max_damage: int
var min_damage: int

export var critical_damage: int
export var critical_damage_chance: int
export var max_distance_shot: int = 50
export var speed: int = 5

var direction := Vector2(-1, 0) setget set_direction
onready var timer = $KillTimer

func _ready():
	timer.start(max_distance_shot / speed * 3)
	
func attack(target):
	var current_dmg = round(rand_range(min_damage, max_damage))
	target.hit(current_dmg)
	queue_free()
	if(target.health <= 0):
		target.death()
	
func _physics_process(delta):
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
