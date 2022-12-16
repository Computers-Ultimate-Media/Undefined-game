extends Sprite

class_name Head

export var healthMax = 100 setget setHealthMax,getHealthMax

static func getDefault():
	var defaultHead = load("res://Player/Head.tscn").instance()
	defaultHead.texture = null
	defaultHead.healthMax = 100
	return defaultHead

func getHealthMax():
	return healthMax

func setHealthMax(value):
	healthMax = value
