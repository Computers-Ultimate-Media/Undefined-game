extends Node2D

class_name Bullet

var bullet_owner = null
var direction := Vector2.ZERO setget setDirection

var damage: int
var time: int
var speed: int
onready var texture: Texture = $Sprite.texture setget setTexture,getTexture
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

func _on_Bullet_body_entered(body):
	if not (body is Player) and not (body is Enemy):
		queue_free()
	
	if (body is Player) and not(bullet_owner is Player):
		attack(body)
	
	elif (body is Enemy) and (bullet_owner is Player):
		attack(body)
		
func _on_KillTimer_timeout():
	queue_free()

func setDirection(newDirection: Vector2):
	direction = newDirection

func getTexture():
	return $Sprite.texture
	
func setTexture(newTexture):
	$Sprite.texture = newTexture
