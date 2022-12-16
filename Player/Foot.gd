extends Sprite

export var moveSpeed = 100 setget setMoveSpeed,getMoveSpeed

static func getDefault():
	var defaultFoot = load("res://Player/Foot.tscn").instance()
	defaultFoot.texture = null
	defaultFoot.moveSpeed = 100
	return defaultFoot

func getMoveSpeed():
	return moveSpeed

func setMoveSpeed(value):
	moveSpeed = value
