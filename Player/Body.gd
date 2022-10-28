extends Sprite

export var hpBody = 100 setget setHpBody,getHpBody
export var hpRegen = 1 setget setHpRegen,getHpRegen

func _ready():
	pass

func getHpBody():
	return hpBody

func setHpBody(value):
	hpBody = value

func getHpRegen():
	return hpRegen

func setHpRegen(value):
	hpRegen = value
