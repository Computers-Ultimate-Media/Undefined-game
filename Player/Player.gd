extends KinematicBody2D

onready var head = $Head setget setHead
onready var body = $Body setget setBody
onready var foot = $Foot setget setFoot

onready var headName = head.name setget setHeadName,getHeadName
onready var bodyName = body.name setget setBodyName,getBodyName
onready var footName = foot.name setget setFootName,getFootName

onready var hpMax = head.hpMax setget setHpMax,getHpMax
onready var hpCurrent = hpMax setget setHpCurrent,getHpCurrent
onready var hpBody = body.hpBody setget setHpBody,getHpBody
onready var hpRegen = body.hpRegen setget setHpRegen,getHpRegen
onready var moveSpeed = foot.moveSpeed setget setMoveSpeed,getMoveSpeed

signal open_inventory

func _input(event):
	if event.is_action_pressed("open_inventory"):
		emit_signal("open_inventory", self)

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

func setHead(newHead):
	remove_child(get_node(head.name))
	
	if not newHead:
		newHead = load("res://Player/Head.tscn").instance()
		newHead.texture = load("res://Assets/Player/Head/empty.png")
		newHead.hpMax = 100
	
	head = newHead
	add_child(newHead)
	
func setBody(newBody):
	remove_child(get_node(body.name))
	
	if not newBody:
		newBody = load("res://Player/Body.tscn").instance()
		newBody.texture = load("res://Assets/Player/Body/empty.png")
		newBody.hpBody = 1000
		newBody.hpRegen = 4
	
	body = newBody
	add_child(newBody)

func setFoot(newFoot):
	remove_child(get_node(foot.name))
	
	if not newFoot:
		newFoot = load("res://Player/Foot.tscn").instance()
		newFoot.texture = load("res://Assets/Player/Foot/empty.png")
		newFoot.moveSpeed = 10
	
	foot = newFoot
	add_child(newFoot)

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
