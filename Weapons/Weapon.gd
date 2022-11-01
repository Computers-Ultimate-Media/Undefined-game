extends Node2D

var Projectile = preload("res://Weapons/Projectile.tscn")

func _ready():
	pass # Replace with function body.
	
func _process(delta):
	pass
	
func shoot():
	var projectile = Projectile.instance()
	var angle_to = get_global_mouse_position().angle_to_point($ShootPoint.global_position)
	angle_to -= 0.785398
	var direction = Vector2.ONE.rotated(angle_to).normalized()
	projectile.set_direction(direction) 
	projectile.global_position = $ShootPoint.global_position
	get_tree().root.get_child(0).add_child(projectile)
