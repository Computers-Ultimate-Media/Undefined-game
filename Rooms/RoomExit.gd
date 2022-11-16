extends Node2D
class_name RoomExit

export var state = false setget set_state
var target : Vector2

func setOpen(state:bool):
	
	if (not target == null):
		$Sprite.visible = !state
		$StaticBody2D/CollisionShape2D.set_deferred("disabled", state)


func teleport(node):
	node.position = target

func _on_Node2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if !($StaticBody2D/CollisionShape2D.disabled):
		teleport(body)
	pass

func set_state(_state):
	state = _state

static func connect_exits(ex1:RoomExit,ex2:RoomExit):
	var pos1 = ex1.get_node("TeleportPosition").global_position
	var pos2 = ex2.get_node("TeleportPosition").global_position
	ex1.target = pos2
	ex2.target = pos1
	
