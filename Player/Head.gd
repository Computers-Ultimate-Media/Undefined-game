extends Sprite

class_name Head

export var hpMax = 100 setget setHpMax,getHpMax

static func getDefault():
	var defaultHead = load("res://Player/Head.tscn").instance()
	defaultHead.texture = null
	defaultHead.hpMax = 100
	return defaultHead

func getHpMax():
	return hpMax

func setHpMax(value):
	hpMax = value
