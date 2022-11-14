extends Position2D

onready var label = $Label
onready var tween = $Tween
var amount = 0

func _ready():
	label.text = str(amount)
	tween.interpolate_property(self, "scale", scale, Vector2(1, 1), 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
