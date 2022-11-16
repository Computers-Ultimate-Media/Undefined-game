class_name RoomDataHolder


var starting_room = "Room1"
var rooms = ["","Room1" ] 

func get_starting_room():
	return starting_room

func get_random_room():
	var rng = RandomNumberGenerator.new()
	return rooms[rng.randi_range(0, rooms.size())] 
	
func _ready():
	pass # Replace with function body.

