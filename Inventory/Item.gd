extends Node2D

var element = null

func init(el):
	element = el

func _ready():
	$TextureRect.texture = element.texture
