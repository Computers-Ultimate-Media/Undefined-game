extends KinematicBody2D

export var maxHP = 150
export var currentHP = 100
export var hpRegen = 1
export var move_speed = 400

var Projectile = preload("res://Weapons/Projectile.tscn")

onready var end_of_gun = get_node("Blade")

var perk_lvl = 6

func getMaxHP():
	return maxHP
	
func getCurrentHP():
	return currentHP
	
func getPerkLVL():
	return perk_lvl
	
func _ready():
	pass
	
func regenerate():
	if(maxHP - currentHP > 0):
		currentHP += hpRegen

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * move_speed
		
		position += velocity * delta
		
	look_at(get_global_mouse_position())

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		var projectile = Projectile.instance()
		var direction = (end_of_gun.get_node("ShootPoint").global_position - global_position).normalized()
		projectile.set_direction(direction) 
		projectile.global_position = end_of_gun.global_position
		get_parent().add_child(projectile)
		
