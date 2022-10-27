extends Sprite
export var hpMax = 120 setget setHpMax,getHpMax

func _ready():
	pass

func getHpMax():
	print("head getHpMax")
	return hpMax

func setHpMax(value):
	print("head setHpMax")
	hpMax = value
