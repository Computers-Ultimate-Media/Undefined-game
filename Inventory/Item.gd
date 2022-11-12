extends Node2D

func _ready():
	if (randi() % 2 == 0):
		$TextureRect.texture = load("res://Assets/Player/Body/cat.png")
	else:
		$TextureRect.texture = load("res://Assets/Player/Head/head.png")
