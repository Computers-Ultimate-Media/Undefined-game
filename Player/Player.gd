extends KinematicBody2D

signal player_stats_changed
signal player_damaged
signal player_dead

onready var head = $Sprite/Head setget setHead
onready var foot = $Sprite/Foot setget setFoot
onready var body = $Sprite/Body setget setBody
onready var weapon = $Blade setget setWeapon

onready var headName = head.name setget setHeadName,getHeadName
onready var bodyName = body.name setget setBodyName,getBodyName
onready var footName = foot.name setget setFootName,getFootName

onready var hpMax = head.hpMax setget setHpMax,getHpMax
onready var health = 5000000 setget setHpCurrent,getHpCurrent
onready var hpRegen = body.hpRegen setget setHpRegen,getHpRegen

onready var armorMax = body.armorMax setget setArmorMax,getArmorMax
onready var armorCurrent = 50 setget setArmorCurrent,getArmorCurrent

onready var moveSpeed = foot.moveSpeed setget setMoveSpeed,getMoveSpeed
onready var coins = 100 setget setCoins, getCoins

var head_array = []
var perk_lvl = 6

var can_regenerate

func _ready():
	player_regenerate(hpRegen)
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
#
	if(Input.is_action_just_released("ui_accept")):
		get_tree().root.get_node("main/Map").generate_map()

	if velocity.length() > 0:

		$Sprite.play("run")
		velocity = velocity.normalized() * moveSpeed
		move_and_slide(velocity)
	else:
		$Sprite.play("idle")
		
func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("scroll_up"):
		$Camera2D.zoom *= 1.1
	if event.is_action_pressed("scroll_down"):
		$Camera2D.zoom *= 0.9

	if event.is_action_pressed("shoot"):
		weapon.shoot()

func player_regenerate(hpRegen):
	if(hpMax - health > 0 && can_regenerate):
		health += hpRegen
		emit_signal("player_stats_changed", self)
		
func _on_HP_timeout():
	can_regenerate = true
	player_regenerate(hpRegen)
	
func setCoins(value):
	coins = value
	
func getCoins():
	return coins
	
func setWeapon(value):
	weapon.queue_free()
	weapon = value
	self.add_child(weapon)
	
func setHead(value):
	(get_node("Sprite/" + head.name)).queue_free()
	head = value
	$Sprite.add_child(value)

func setBody(value):
	(get_node("Sprite/" + body.name)).queue_free()
	body = value
	$Sprite.add_child(value)

func setFoot(value):
	(get_node("Sprite/" + foot.name)).queue_free()
	foot = value
	$Sprite.add_child(value)
	
func setHeadName(value):
	head.name = value

func getHeadName():
	return head.name

func setBodyName(value):
	body.name = value

func getBodyName():
	return body.name

func setFootName(value):
	foot.name = value

func getFootName():
	return foot.name

func getHpMax():
	return head.hpMax

func setHpMax(value):
	head.hpMax = value
	
func getHpCurrent():
	return health

func setHpCurrent(value):
	health = value

func getArmorCurrent():
	return armorCurrent

func setArmorCurrent(value):
	armorCurrent = value
	
func getArmorMax():
	return body.armorMax

func setArmorMax(value):
	body.armorMax = value

func getHpRegen():
	return body.hpRegen

func setHpRegen(value):
	body.hpRegen = value

func getMoveSpeed():
	return foot.moveSpeed

func setMoveSpeed(value):
	foot.moveSpeed = value

func getPerkLVL():
	return perk_lvl

func hit(damage):
	$Timer/HP.start()
	health -= damage
	emit_signal("player_damaged")

func death():
	self.queue_free()
	emit_signal("player_dead")

func _on_Player_player_damaged():
	emit_signal("player_stats_changed", self)
