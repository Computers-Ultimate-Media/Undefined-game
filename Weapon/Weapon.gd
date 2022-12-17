extends Node2D

var Bullet = preload("res://Weapon/Bullet.tscn")
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
		
	var bullet = Bullet.instance()
	add_child(bullet)
	bullet.global_position = $ShootPoint.global_position
	var direction_to_mouse = $ShootPoint.global_position.direction_to(target_position).normalized()

	bullet.setDirection(direction_to_mouse)
	bullet.set_weapon_owner(weapon_owner)

	bullet.damage = calculate_damage()
	bullet.time = max_distance_shot / speed
	bullet.speed = speed


func calculate_damage():
	var damage = round(rand_range(min_damage, max_damage))
	if(rand_range(0, 100) < critical_damage_chance):
		damage = damage * (critical_damage / 100)
	return damage

func get_reload_time():
	return reload_time

func get_shooting_distance():
	return max_distance_shot
