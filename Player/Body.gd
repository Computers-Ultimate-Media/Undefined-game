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

static func fromArray(array_bodies_dict: Array) -> Array:
	var bodies: Array
	for bodies_dict in array_bodies_dict:
		var body = load("res://Player/Body.tscn").instance()
		body.texture = load(bodies_dict["texture"])
		body.armorMax = bodies_dict["armorMax"]
		body.healthRegen = bodies_dict["HealthRegen"]

		body.name = bodies_dict["name"]

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

