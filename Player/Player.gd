extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var hp = 100
export var move_speed = 400

func getHP():
	return hp
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



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
#
	if(Input.is_action_just_released("ui_accept")):
		get_tree().root.get_node("main/Map").generate_map()

	if velocity.length() > 0:
		velocity = velocity.normalized() * move_speed
		
		
		move_and_slide(velocity)

func _unhandled_input(event):
	
	if event.is_action_pressed("scroll_up"):
		$Camera2D.zoom *= 1.1
	if event.is_action_pressed("scroll_down"):
		$Camera2D.zoom *= 0.9
