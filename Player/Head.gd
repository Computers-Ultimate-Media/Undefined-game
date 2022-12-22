extends Sprite
class_name Head

export var healthMax = 100 setget setHealthMax,getHealthMax

static func getDefault():
	var defaultHead = load("res://Player/Head.tscn").instance()
	defaultHead.texture = null
	defaultHead.healthMax = 100
	return defaultHead

static func fromArray(array_heads_dict: Array) -> Array:
	var heads: Array
	for heads_dict in array_heads_dict:
		var head = load("res://Player/Head.tscn").instance()
		head.texture = load(heads_dict["texture"])
		head.healthMax = heads_dict["healthMax"]
		head.name = heads_dict["name"]

		heads.append(head)

	return heads

func getHealthMax():
	return healthMax

func setHealthMax(value):
	healthMax = value
