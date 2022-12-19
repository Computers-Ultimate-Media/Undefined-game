extends Sprite
class_name Foot

export var moveSpeed = 100 setget setMoveSpeed,getMoveSpeed

static func getDefault():
	var defaultFoot = load("res://Player/Foot.tscn").instance()
	defaultFoot.texture = null
	defaultFoot.moveSpeed = 100
	return defaultFoot

static func fromJsonArray(path: String) -> Array:
	var feet = []
	var dict_feet = Utils.read_from_JSON(path)
	for key in dict_feet.keys():
		var foot = load("res://Player/Foot.tscn").instance()
		foot.texture = load(dict_feet[key]["texture"])
		foot.moveSpeed = dict_feet[key]["moveSpeed"]

		foot.name = key

		feet.append(foot)

	return feet

func getMoveSpeed():
	return moveSpeed

func setMoveSpeed(value):
	moveSpeed = value
