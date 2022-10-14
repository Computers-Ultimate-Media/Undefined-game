extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func update_hp(player_maxHp, player_curHp):
	$PlayerHP.text = "Your hp:" + str(player_curHp) + "/" + str(player_maxHp)
