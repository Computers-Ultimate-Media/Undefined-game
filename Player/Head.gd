extends Sprite
class_name Head

export var healthMax = 100 setget setHealthMax,getHealthMax

static func getDefault():
	var defaultHead = load("res://Player/Head.tscn").instance()
	defaultHead.texture = null
	defaultHead.healthMax = 100
	return defaultHead

static func fromJsonArray(path: String) -> Array:
	var heads = []
	var dict_heads = Utils.read_from_JSON(path)
	for key in dict_heads.keys():
		var head = load("res://Player/Head.tscn").instance()
		head.texture = load(dict_heads[key]["texture"])
		head.healthMax = dict_heads[key]["healthMax"]
		head.name = key

		heads.append(head)

	return heads

func getHealthMax():
	return healthMax

func setHealthMax(value):
	healthMax = value
