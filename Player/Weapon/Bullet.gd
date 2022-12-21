extends Node2D

class_name Bullet

var bullet_owner = null
var direction := Vector2.ZERO setget setDirection

var damage: int
var lifetime: float = -1
var speed: int = 0
onready var texture: Texture = $Sprite.texture setget setTexture,getTexture
onready var timer = $KillTimer

func _ready():
	if lifetime != -1:
		print("_ready " + str(global_position))
		timer.start(lifetime)

func _physics_process(delta):
	if direction != Vector2.ZERO:
		var velocity = direction * speed
		global_position += velocity

func set_shooting_range(shooting_distance, bullet_speed):
	self.speed = bullet_speed
	self.lifetime = 0.26 * shooting_distance / bullet_speed
	if timer:
		timer.start(lifetime)
		print("set_shooting_range " + str(global_position))


func attack(target):
	target.hit(damage)
	queue_free()

func _on_Bullet_body_entered(body):
#	if not body: return

	if not (body is Player) and not (body is Enemy):
		queue_free()
	
	if (body is Player) and not(bullet_owner is Player):
		attack(body)
	
	elif (body is Enemy) and (bullet_owner is Player):
		attack(body)
		
func _on_KillTimer_timeout():
	queue_free()
	print("_on_KillTimer_timeout " + str(global_position))


func setDirection(newDirection: Vector2):
	direction = newDirection

func getTexture():
	return $Sprite.texture
	
func setTexture(newTexture):
	$Sprite.texture = newTexture
