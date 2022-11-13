extends KinematicBody2D

class_name Enemy

var player = null
var target = null

onready var projectile 
onready var weapon = $Blade

var velocity = Vector2.ZERO
var last_direction = Vector2(0, 1)
var bounce_countdown = 0

export var health = 100
export var max_health = 100
export var damage = 10
export var speed = 1000

signal enemy_dead;
signal enemy_hit;
signal enemy_shoot;

onready var health_bar = $HeathBar

func _ready():
	player = get_tree().root.get_node("main/Player")
	health_bar._on_max_health_updated(max_health)
	
func _physics_process(delta):
	velocity = Vector2.ZERO
	if target != null:
		velocity = position.direction_to(target.position) * speed
	else:
		velocity = Vector2.ZERO
	velocity = velocity.normalized()
	velocity = move_and_collide(velocity)

func hit(damage):
	health -= damage
	emit_signal("enemy_hit")
	health_bar._display_health_bar(true)

func death():
	self.queue_free()
	emit_signal("enemy_dead")

func _on_Enemy_enemy_dead():
	player.setCoins(player.getCoins() + 10)

func _on_Enemy_enemy_hit():
	health_bar._on_health_updated(health, 0)

func _on_PlayerFindArea_body_entered(body):
	if body.name == "Player":
		target = body
		$ShootTimer.start()

func _on_PlayerFindArea_body_exited(body):
	target = null

func _on_ShootTimer_timeout():
	emit_signal("enemy_shoot")

func _on_Enemy_enemy_shoot():
	if target != null:
		weapon.target = target
		weapon.shoot()
		$ShootTimer.wait_time = 1
