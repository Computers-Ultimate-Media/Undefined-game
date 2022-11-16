extends Node2D

var Projectile = preload("res://Weapons/Projectile.tscn")
var target = null
var target_position = null

export var weapon_owner = "title_"
export var max_damage = 10
export var min_damage = 5

export var critical_damage: int
export var critical_damage_chance: int
export var max_distance_shot: int
export var speed: int

export var reload_time: int

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
	projectile.set_direction(direction) 
	
	projectile.damage = calculate_damage()
	projectile.time = max_distance_shot / speed
	projectile.speed = speed
	
	get_tree().root.get_child(0).add_child(projectile)

func calculate_damage():
	var damage = round(rand_range(min_damage, max_damage))
	if(rand_range(0, 100) < critical_damage_chance):
		damage = damage * (critical_damage / 100)
		print("crit!")
	return damage

func get_reload_time():
	return reload_time

func get_shooting_distance():
	return max_distance_shot
