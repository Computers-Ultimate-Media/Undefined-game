extends Node2D

class_name Bullet

var direction := Vector2.ZERO setget setDirection
var weapon_owner setget set_weapon_owner
var damage: int
var time: int
var speed: int
onready var texture: StreamTexture = $Sprite.texture setget setTexture,getTexture
onready var timer = $KillTimer

func _ready():
	timer.start(time / 3)

func _physics_process(delta):
	if direction != Vector2.ZERO:
		var velocity = direction * speed
		global_position += velocity

func attack(target):
	target.hit(damage)
#	queue_free()
	if(target.health <= 0):
		target.death()

func set_weapon_owner(value):
	weapon_owner = value

func setDirection(newDirection: Vector2):
	direction = newDirection

func _on_KillTimer_timeout():
	queue_free()

func _on_Bullet_body_entered(body):
	if body.name == "TileMap" \
	or body.name == "StaticBody2D":
		queue_free()
	else:
		if !body.name.begins_with(weapon_owner) && !body.name.begins_with("@"+weapon_owner) :
			attack(body)

#	if body.has_method("hit"):
#		attack(body)
#	queue_free()

func getTexture():
	return $Sprite.texture
	
func setTexture(newTexture):
	$Sprite.texture = newTexture
