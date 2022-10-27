extends KinematicBody2D

var Projectile = preload("res://Weapons/Projectile.tscn")

onready var end_of_gun = $Blade

onready var head = $"%Head" setget setHead
onready var feet = $"%Feet" setget setFeet
onready var body = $"%Body" setget setBody

onready var hpMax = head.hpMax setget setHpMax,getHpMax
onready var hpCurrent = hpMax setget setHpCurrent,getHpCurrent
onready var hpBody = body.hpBody setget setHpBody,getHpBody
onready var hpRegen = body.hpRegen setget setHpRegen,getHpRegen
onready var moveSpeed = feet.moveSpeed setget setMoveSpeed,getMoveSpeed

var head_array = []

var perk_lvl = 6

func _ready():
	print(head.texture)
	print(feet.texture)
	print(body.texture)
	pass


func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * moveSpeed
		position += velocity * delta
		
	look_at(get_global_mouse_position())

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		var projectile = Projectile.instance()
		var direction = (end_of_gun.get_node("ShootPoint").global_position - global_position).normalized()
		projectile.set_direction(direction) 
		projectile.global_position = end_of_gun.global_position
		get_parent().add_child(projectile)


func setHead(value):
	head = value
	value.name = "Head"
	$"%Head".queue_free()
	$Sprite.add_child(value, true)

func setBody(value):
	body = value
	value.name = "Body"
	$"%Body".queue_free()
	$Sprite.add_child(value, true)

func setFeet(value):
	feet = value
	value.name = "Feet"
	$"%Feet".queue_free()
	$Sprite.add_child(value, true)

func getHpMax():
	print("player getHpMax")
	return head.hpMax

func setHpMax(value):
	print("player setHpMax")
	head.hpMax = value
	
func getHpCurrent():
	print("player getHpCurrent")
	return hpCurrent

func setHpCurrent(value):
	print("player setHpCurrent")
	hpCurrent = value

func getHpBody():
	print("player getHpBody")
	return body.hpBody

func setHpBody(value):
	print("player setHpBody")
	body.hpBody = value

func getHpRegen():
	print("player getHpRegen")
	return body.hpRegen

func setHpRegen(value):
	print("player setHpRegen")
	body.hpRegen = value

func getMoveSpeed():
	print("player getMoveSpeed")
	return feet.moveSpeed

func setMoveSpeed(value):
	print("player setMoveSpeed")
	feet.moveSpeed = value

func getPerkLVL():
	return perk_lvl
