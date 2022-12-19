extends KinematicBody2D
class_name Player

signal player_stats_changed
signal player_damaged
signal player_dead
signal open_inventory

onready var head = $Sprite/Head setget setHead
onready var foot = $Sprite/Foot setget setFoot
onready var body = $Sprite/Body setget setBody
onready var weapon = $Weapon setget setWeapon

onready var healthMax = head.healthMax setget setHealthMax,getHealthMax
onready var health = head.healthMax setget setHealth,getHealth
onready var HealthRegen = body.healthRegen setget setHealthRegen,getHealthRegen

onready var armorMax = body.armorMax setget setArmorMax,getArmorMax
onready var armor = 50 setget setArmor,getArmor

onready var moveSpeed = foot.moveSpeed setget setMoveSpeed,getMoveSpeed
onready var coins = 100 setget setCoins, getCoins

var perk_lvl = 6
var can_regenerate

func _ready():
	player_regenerate(HealthRegen)
	emit_signal("player_stats_changed", self)
	$Timer/HP.wait_time = 2

func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		$Sprite.flip_h = false
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		$Sprite.flip_h = true
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		$Sprite.play("run")
		velocity = velocity.normalized() * self.moveSpeed
		move_and_slide(velocity)
	else:
		$Sprite.play("idle")
		
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("scroll_up"):
		$Camera2D.zoom *= 0.9
	if event.is_action_pressed("scroll_down"):
		$Camera2D.zoom *= 1.1
	if event.is_action_pressed("open_inventory"):
		emit_signal("open_inventory", self)
	if event.is_action_pressed("shoot"):
		weapon.shoot(get_global_mouse_position())

func player_regenerate(HealthRegen):
	if(self.healthMax - self.health > 0 && can_regenerate):
		self.health += self.HealthRegen
		emit_signal("player_stats_changed", self)

func _on_HP_timeout():
	can_regenerate = true
	player_regenerate(HealthRegen)

func hit(damage):
	$Timer/HP.start()
	self.health -= damage
	emit_signal("player_damaged")

func death():
	self.queue_free()
	emit_signal("player_dead")

func _on_Player_player_damaged():
	emit_signal("player_stats_changed", self)


func setWeapon(newWeapon):
	remove_child(get_node(weapon.name))

	if not newWeapon:
		newWeapon = load("res://Player/Weapon/Weapon.gd").getDefault()

	weapon = newWeapon
	add_child(newWeapon)
	emit_signal("player_stats_changed", self)

func setHead(newHead):
	$Sprite.remove_child($Sprite.get_node(head.name))

	if not newHead:
		newHead = load("res://Player/Head.gd").getDefault()
	
	head = newHead
	$Sprite.add_child(newHead)
	emit_signal("player_stats_changed", self)


func setBody(newBody):
	$Sprite.remove_child($Sprite.get_node(body.name))

	if not newBody:
		newBody = load("res://Player/Body.gd").getDefault()

	body = newBody
	$Sprite.add_child(newBody)
	emit_signal("player_stats_changed", self)


func setFoot(newFoot):
	$Sprite.remove_child($Sprite.get_node(foot.name))

	if not newFoot:
		newFoot = load("res://Player/Foot.gd").getDefault()

	foot = newFoot
	$Sprite.add_child(newFoot)
	emit_signal("player_stats_changed", self)


func getHealth():
	return health

func setHealth(value):
	health = value

func getArmor():
	return armor

func setArmor(value):
	armor = value

func getArmorMax():
	return body.armorMax

func setArmorMax(value):
	body.armorMax = value

func getHealthMax():
	return head.healthMax

func setHealthMax(value):
	head.healthMax = value

func getHealthRegen():
	return body.healthRegen

func setHealthRegen(value):
	body.healthRegen = value

func getMoveSpeed():
	return foot.moveSpeed

func setMoveSpeed(value):
	foot.moveSpeed = value


func setCoins(value):
	coins = value

func getCoins():
	return coins
