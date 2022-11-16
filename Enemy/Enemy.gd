extends KinematicBody2D

class_name Enemy


var player = null
var target = null

onready var floating_text = preload("res://HUD/InGameHUD/FloatingText.tscn") 

onready var projectile 
onready var weapon = $Blade
onready var health_bar = $HeathBar

var velocity = Vector2.ZERO
var last_direction = Vector2(0, 1)
var shooting_time
var shooting_distance

export var health : int
export var max_health : int
export var speed : int

signal enemy_death

func _ready():
	shooting_time = weapon.get_reload_time()
	shooting_distance = weapon.get_shooting_distance()
	player = get_tree().root.get_node("main/Player")
	health_bar._on_max_health_updated(max_health)

func _process(delta):

	velocity = Vector2.ZERO
	
	if (self.global_position.distance_to(player.global_position)) < 350:
		target = player
		
		velocity = self.global_position.direction_to(target.global_position) * speed
		if (self.global_position.distance_to(player.global_position)) < shooting_distance:
			velocity = Vector2.ZERO
			
		if($ShootTimer.is_stopped()):
			enemy_shoot()
			$ShootTimer.start()
	else:
		velocity = Vector2.ZERO
		target = null
		$ShootTimer.stop()
		
	velocity = velocity.normalized()
	velocity = move_and_collide(velocity)

func hit(damage):
	var text = floating_text.instance()
	text.amount = damage
	text.position = self.position
	get_tree().root.add_child(text)
	
	health -= damage
	health_bar._on_health_updated(health, 0)
	health_bar._display_health_bar(true)


func death():
	emit_signal("enemy_death")
	self.queue_free()
	player.setCoins(player.getCoins() + 10)

func _on_ShootTimer_timeout():
	enemy_shoot()

func enemy_shoot():
	if target != null:
		weapon.target = target
		weapon.shoot()
		$ShootTimer.wait_time = shooting_time


