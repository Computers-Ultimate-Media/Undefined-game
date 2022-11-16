extends Position2D

onready var label = $Label
onready var tween = $Tween
var amount = 0

func _ready():
	label.text = str(amount)
	tween.interpolate_property(self, "position", self.position, self.position + Vector2(30, -70), 0.6, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.interpolate_property(self, "scale", self.scale, Vector2(0.8, 0.8), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
#	tween.interpolate_property(label.get_font("font"), "outline_color", Color(1, 1, 1, 1), Color(1, 0, 0, 1), 3, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start() 
	
	$FreeTimer.start(1)

func _on_FreeTimer_timeout():
	queue_free()
