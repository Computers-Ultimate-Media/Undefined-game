extends Node2D

var Projectile = preload("res://Weapons/Projectile.tscn")
var target = null
var target_position = null

export var weapon_owner = "title_"
export var max_damage = 10
export var min_damage = 5

func shoot():
	if weapon_owner == "Player":
		target_position = get_global_mouse_position()
	else:
		target_position = target.global_position
		
	var angle_to = target_position.angle_to_point($ShootPoint.global_position) - 0.785398
	var projectile = Projectile.instance()
	var direction = Vector2.ONE.rotated(angle_to).normalized()
	
	projectile.global_position = $ShootPoint.global_position
	projectile.set_weapon_owner(weapon_owner)
	projectile.max_damage = max_damage
	projectile.min_damage = min_damage
	projectile.set_direction(direction) 
	
	get_tree().root.get_child(0).add_child(projectile)
