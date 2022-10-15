extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func setOpen(state:bool):
	var collisionShape2D = get_node("%CollisionShape2D") as CollisionShape2D
	collisionShape2D.set_deferred("disabled", state)
	print_debug(state)
	
	if(state):
		$Sprite.modulate = Color(1,0,0,1)
	else:
		$Sprite.modulate = Color(1,0,0,1)
	


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
