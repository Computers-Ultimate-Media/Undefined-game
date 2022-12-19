extends Sprite

export var armorMax = 0 setget setArmorMax,getArmorMax
export var healthRegen = 0 setget setHealthRegen,getHealthRegen

static func getDefault():
	var defaultBody = load("res://Player/Body.tscn").instance()
	defaultBody.texture = null
	defaultBody.armorMax = 0
	defaultBody.healthRegen = 0
	return defaultBody

func getArmorMax():
	return armorMax

func setArmorMax(value):
	armorMax = value

func getHealthRegen():
	return healthRegen

func setHealthRegen(value):
	healthRegen = value

