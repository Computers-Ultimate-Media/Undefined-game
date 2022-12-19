extends Sprite
class_name Body

export var armorMax = 0 setget setArmorMax,getArmorMax
export var healthRegen = 0 setget setHealthRegen,getHealthRegen

static func getDefault():
	var defaultBody = load("res://Player/Body.tscn").instance()
	defaultBody.texture = null
	defaultBody.armorMax = 0
	defaultBody.healthRegen = 0
	return defaultBody

static func fromJsonArray(path: String) -> Array:
	var bodies = []
	var dict_bodies = Utils.read_from_JSON(path)
	for key in dict_bodies.keys():
		var body = load("res://Player/Body.tscn").instance()
		body.texture = load(dict_bodies[key]["texture"])
		body.armorMax = dict_bodies[key]["armorMax"]
		body.healthRegen = dict_bodies[key]["HealthRegen"]

		body.name = key

		bodies.append(body)

	return bodies

func getArmorMax():
	return armorMax

func setArmorMax(value):
	armorMax = value

func getHealthRegen():
	return healthRegen

func setHealthRegen(value):
	healthRegen = value

