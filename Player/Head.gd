extends Sprite

export var hpMax = 120 setget setHpMax,getHpMax

func _ready():
	pass

func getHpMax():
	return hpMax

func setHpMax(value):
	hpMax = value
