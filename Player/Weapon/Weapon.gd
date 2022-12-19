extends Node2D
class_name Weapon

var Bullet = preload("res://Player/Weapon/Bullet.tscn")

export (int) var maxDamage = 10
export (int) var minDamage = 5
# percent chance from 100 to ...
export (int) var criticalDamagePercentage =  140
# percent chance from 0 to 100
export (int) var criticalDamageChance = 20
export (int) var shootingDistance = 200
export (int) var bulletSpeed = 6
export (int) var reloadTime = 0 setget ,getReloadTime
export (Texture) var texture = load("res://Assets/Weapon/magic_wand.png") setget setTexture,getTexture
export (Texture) var bulletTexture = load("res://Assets/Weapon/magic_wand_fire.png") 

func shoot(targetShootPoint: Vector2):
	var bullet = Bullet.instance()

	bullet.bullet_owner = get_parent()

	bullet.damage = self.calculate_damage()
	bullet.texture = bulletTexture.duplicate()
	bullet.time = shootingDistance / bulletSpeed
	bullet.speed = bulletSpeed
	bullet.global_position = $ShootPoint.global_position
	var direction_to_mouse = $ShootPoint.global_position.direction_to(targetShootPoint).normalized()
	
	bullet.setDirection(direction_to_mouse)
	get_tree().root.add_child(bullet)


func calculate_damage() -> int:
	var damage = round(rand_range(minDamage, maxDamage))
	if (rand_range(0, 100) < criticalDamageChance):
		damage *= (criticalDamagePercentage / 100)
	return damage

static func getDefault():
	var defaultWeapon = load("res://Player/Weapon/Weapon.tscn").instance()
	defaultWeapon.maxDamage = 10
	defaultWeapon.minDamage = 5
	defaultWeapon.criticalDamagePercentage = 140
	defaultWeapon.criticalDamageChance = 20
	defaultWeapon.shootingDistance = 200
	defaultWeapon.bulletSpeed = 6
	defaultWeapon.reloadTime = 0
	defaultWeapon.bulletTexture = load("res://Assets/Weapon/magic_wand_fire.png")
	defaultWeapon.texture = load("res://Assets/Weapon/magic_wand.png")

	defaultWeapon.name = "Weapon"
	return defaultWeapon

static func fromJsonArray(path: String) -> Array:
	var weapons = []
	var dict_weapons = Utils.read_from_JSON(path)
	for key in dict_weapons.keys():
		var weapon = load("res://Player/Weapon/Weapon.tscn").instance()

		weapon.maxDamage = dict_weapons[key]["maxDamage"]
		weapon.minDamage = dict_weapons[key]["minDamage"]
		weapon.criticalDamagePercentage = dict_weapons[key]["criticalDamagePercentage"]
		weapon.criticalDamageChance = dict_weapons[key]["criticalDamageChance"]
		weapon.shootingDistance = dict_weapons[key]["shootingDistance"]
		weapon.bulletSpeed = dict_weapons[key]["bulletSpeed"]
		weapon.reloadTime = dict_weapons[key]["reloadTime"]
		weapon.bulletTexture = load(dict_weapons[key]["bulletTexture"])
		weapon.texture = load(dict_weapons[key]["texture"])
		
		weapon.name = key

		weapons.append(weapon)

	return weapons

func getTexture():
	return $Sprite.texture
	
func setTexture(newTexture):
	$Sprite.texture = newTexture

func getReloadTime():
	return reloadTime

func getShootingDistance():
	return shootingDistance
