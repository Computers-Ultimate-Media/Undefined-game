extends KinematicBody2D

onready var head = $Sprite/Head setget setHead
onready var foot = $Sprite/Foot setget setFoot
onready var body = $Sprite/Body setget setBody

onready var headName = head.name setget setHeadName,getHeadName
onready var bodyName = body.name setget setBodyName,getBodyName
onready var footName = foot.name setget setFootName,getFootName

onready var hpMax = head.hpMax setget setHpMax,getHpMax
onready var hpCurrent = hpMax setget setHpCurrent,getHpCurrent
onready var hpBody = body.hpBody setget setHpBody,getHpBody
onready var hpRegen = body.hpRegen setget setHpRegen,getHpRegen
onready var moveSpeed = foot.moveSpeed setget setMoveSpeed,getMoveSpeed


func _ready():
	print_tree()
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
