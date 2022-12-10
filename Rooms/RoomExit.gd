extends Node2D
class_name RoomExit

export var state = false setget set_state
var target : Vector2 = Vector2.ZERO

func _ready() -> void:
	set_state(false)

func teleport(node):
	print_debug(target)
	node.global_position = target

func _on_Node2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if (body.name.begins_with("Player")) && state:
		teleport(body)
	pass

func set_state(_state):
	if (target == Vector2.ZERO):
		_state = false
	
	state = _state
	$Sprite.visible = !state
	$StaticBody2D/CollisionShape2D.set_deferred("disabled", state)

static func connect_exits(ex1:RoomExit,ex2:RoomExit):
	var pos1 = ex1.get_node("TeleportPosition").global_position
	var pos2 = ex2.get_node("TeleportPosition").global_position
	ex1.target = pos2
	ex2.target = pos1
	
