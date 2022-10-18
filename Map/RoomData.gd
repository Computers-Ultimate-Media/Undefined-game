class_name RoomData
var room: PackedScene
var size: Vector2
var exits: Dictionary
	
func _init(_room:String, _size:Vector2, _exits:Dictionary):
	room = load("res://Rooms/"+_room+".tscn")
	size = _size
	exits = _exits
