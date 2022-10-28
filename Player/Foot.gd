extends Sprite

export var moveSpeed = 800 setget setMoveSpeed,getMoveSpeed

func _ready():
	pass

func getMoveSpeed():
	print("foot getMoveSpeed")
	return moveSpeed

func setMoveSpeed(value):
	print("foot setMoveSpeed")
	moveSpeed = value
