extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var target : Vector2

func setOpen(state:bool):
	
	if (not target == null):
		$Sprite.visible = !state
		$StaticBody2D/CollisionShape2D.set_deferred("disabled", state)



# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Node2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if !($StaticBody2D/CollisionShape2D.disabled):
		body.position = target
	pass # Replace with function body.
