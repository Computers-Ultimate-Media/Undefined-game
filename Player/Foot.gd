extends Sprite

export var moveSpeed = 800 setget setMoveSpeed,getMoveSpeed

func _ready():
	pass

func getMoveSpeed():
	return moveSpeed

func setMoveSpeed(value):
	moveSpeed = value
