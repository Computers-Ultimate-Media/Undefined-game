extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Player

# Called when the node enters the scene tree for the first time.
func _ready():
	Player = get_node("Player")
	$HUD.update_score(Player.getHP())
