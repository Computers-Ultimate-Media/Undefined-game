extends Sprite
class_name Foot

export var moveSpeed = 100 setget setMoveSpeed,getMoveSpeed

static func getDefault():
	var defaultFoot = load("res://Player/Foot.tscn").instance()
	defaultFoot.texture = null
	defaultFoot.moveSpeed = 100
	return defaultFoot

static func fromArray(array_feet_dict: Array) -> Array:
	var feet: Array
	for feet_dict in array_feet_dict:
		var foot = load("res://Player/Foot.tscn").instance()
		foot.texture = load(feet_dict["texture"])
		foot.moveSpeed = feet_dict["moveSpeed"]

		foot.name = feet_dict["name"]

		feet.append(foot)

	return feet

func getMoveSpeed():
	return moveSpeed

func setMoveSpeed(value):
	moveSpeed = value
