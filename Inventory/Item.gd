extends Node2D

var element = null

func init(el):
	element = el
	$TextureRect.texture = element.texture
