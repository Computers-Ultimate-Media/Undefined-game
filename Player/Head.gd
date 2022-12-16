extends Sprite

class_name Head

export var healthMax = 100 setget setHpMax,getHpMax

static func getDefault():
	var defaultHead = load("res://Player/Head.tscn").instance()
	defaultHead.texture = null
	defaultHead.healthMax = 100
	return defaultHead

func getHpMax():
	return healthMax

func setHpMax(value):
	healthMax = value
