extends Node2D

var Bullet = preload("res://Weapon/Bullet.tscn")
var target = null
var target_position = null

export var weapon_owner = "title_"
export var maxDamage = 10
export var minDamage = 5

# percent chance from 100 to ...
export var criticalDamage: int
# percent chance from 0 to 100
export var criticalDamageChance: int

export var shootingDistance: int
export var speed: int

export var reloadTime: int setget ,getReloadTime

func shoot():
	if weapon_owner == "Player":
		target_position = get_global_mouse_position()
	else:
		target_position = target.global_position
		
	var bullet = Bullet.instance()
	get_tree().root.add_child(bullet)
	bullet.global_position = $ShootPoint.global_position
	var direction_to_mouse = $ShootPoint.global_position.direction_to(target_position).normalized()

	bullet.setDirection(direction_to_mouse)
	bullet.set_weapon_owner(weapon_owner)

	bullet.damage = calculate_damage()
	bullet.time = shootingDistance / speed
	bullet.speed = speed


func calculate_damage() -> int:
	var damage = round(rand_range(minDamage, maxDamage))
	if(rand_range(0, 100) < criticalDamageChance):
		damage = damage * (criticalDamage / 100)
	return damage


func getReloadTime():
	return reloadTime

func getShootingDistance():
	return shootingDistance
