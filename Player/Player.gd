extends KinematicBody2D

signal player_stats_changed

onready var head = $Sprite/Head setget setHead
onready var foot = $Sprite/Foot setget setFoot
onready var body = $Sprite/Body setget setBody
onready var weapon = $Blade setget setWeapon

onready var headName = head.name setget setHeadName,getHeadName
onready var bodyName = body.name setget setBodyName,getBodyName
onready var footName = foot.name setget setFootName,getFootName

onready var hpMax = head.hpMax setget setHpMax,getHpMax
onready var hpCurrent = 50 setget setHpCurrent,getHpCurrent
onready var hpBody = body.hpBody setget setHpBody,getHpBody
onready var hpRegen = body.hpRegen setget setHpRegen,getHpRegen
onready var moveSpeed = foot.moveSpeed setget setMoveSpeed,getMoveSpeed
onready var coins = 100 setget setCoins, getCoins

var head_array = []

var perk_lvl = 6
var can_regenerate

func setCoins(value):
	coins = value
func getCoins():
	return coins
	
func _ready():
	#init emit signal
	emit_signal("player_stats_changed", self)
	
	$Timer/HP.wait_time = 2
	player_damaged()
	
func player_damaged():
	$Timer/HP.start()

func player_regenerate(hpRegen):
	#todo: regeneration
	if(hpMax - hpCurrent > 0 && can_regenerate):
		hpCurrent += hpRegen
		emit_signal("player_stats_changed", self)
		
func _on_HP_timeout():
	can_regenerate = true
	player_regenerate(hpRegen)

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
		velocity = velocity.normalized() * moveSpeed
		position += velocity * delta
	else:
		$Sprite.play("idle")
		
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		weapon.shoot()

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
	return hpCurrent

func setHpCurrent(value):
	hpCurrent = value

func getHpBody():
	return body.hpBody

func setHpBody(value):
	body.hpBody = value

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

