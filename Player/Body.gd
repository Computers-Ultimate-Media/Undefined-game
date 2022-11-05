extends Sprite

export var armorMax = 100 setget setArmorMax,getArmorMax
export var hpRegen = 1 setget setHpRegen,getHpRegen

func _ready():
	pass

func getArmorMax():
	return armorMax

func setArmorMax(value):
	armorMax = value

func getHpRegen():
	return hpRegen

func setHpRegen(value):
	hpRegen = value
