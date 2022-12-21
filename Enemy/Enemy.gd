extends KinematicBody2D

class_name Enemy

onready var floating_text = preload("res://HUD/InGameHUD/FloatingText.tscn") 
onready var weapon = $Blade
onready var health_bar = $HeathBar

export var health : int
export var max_health : int
export var speed : int

var nav2d : Navigation2D
var path : Array = []
var velocity : Vector2 = Vector2.ZERO
var player = null
var target = null

var shooting_time
var shooting_distance

signal enemy_death

func _ready():
	shooting_time = weapon.reloadTime
	shooting_distance = weapon.shootingDistance
	player = get_tree().root.get_node("main/Player")
	health_bar._on_max_health_updated(max_health)

func _process(delta):
	if (self.global_position.distance_to(player.global_position)) < 350:
		target = player 
		
		if target and nav2d:
			generate_path()
			navigate(delta)
		move()
		
		if (self.global_position.distance_to(target.global_position)) < shooting_distance:
			velocity = Vector2.ZERO
			
			if($ShootTimer.is_stopped()):
				enemy_shoot()
				$ShootTimer.start()
	else:
		velocity = Vector2.ZERO
		target = null
		$ShootTimer.stop()

func navigate(delta):
	if path.size() > 0:
		velocity = global_position.direction_to(path[1]) * speed
		if global_position == path[0]:
			path.pop_front()

func generate_path():
	if nav2d != null and target != null:
		path = nav2d.get_simple_path(global_position, target.global_position, false)
	
func move():
	velocity = move_and_slide(velocity)

func hit(damage):
	var text = floating_text.instance()
	text.amount = damage
	text.position = self.position
	get_tree().root.add_child(text)

	self.health -= damage
	if self.health <= 0:
		self.death()
	health_bar._on_health_updated(health, 0)
	health_bar._display_health_bar(true)

func death():
	self.queue_free()
	emit_signal("enemy_death")	
	player.setCoins(player.getCoins() + 10)

func _on_ShootTimer_timeout():
	enemy_shoot()

func enemy_shoot():
	if player != null:
		weapon.shoot(player.global_position)
		$ShootTimer.wait_time = shooting_time
