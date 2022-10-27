extends Sprite

export var hpBody = 100 setget setHpBody,getHpBody
export var hpRegen = 1 setget setHpRegen,getHpRegen

func _ready():
	pass

func getHpBody():
	print("body getHpBody")
	return hpBody

func setHpBody(value):
	print("body setHpBody")
	hpBody = value

func getHpRegen():
	print("body getHpRegen")
	return hpRegen

func setHpRegen(value):
	print("body setHpRegen")
	hpRegen = value
