extends Sprite

export var armorMax = 0 setget setArmorMax,getArmorMax
export var hpRegen = 0 setget setHpRegen,getHpRegen

static func getDefault():
	var defaultBody = load("res://Player/Body.tscn").instance()
	defaultBody.texture = null
	defaultBody.armorMax = 0
	defaultBody.hpRegen = 0
	return defaultBody

func getArmorMax():
	return armorMax

func setArmorMax(value):
	armorMax = value

func getHpRegen():
	return hpRegen

func setHpRegen(value):
	hpRegen = value

