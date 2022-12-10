class_name RoomDataHolder


var starting_rooms = ["Room1","Room1"]
var rooms = ["Room1","Room1"] 
var boss_rooms = ["Room1","Room1"] 

func get_starting_room():
	var rng = RandomNumberGenerator.new()
	return starting_rooms[rng.randi_range(0, starting_rooms.size()-1)] 

func get_random_room():
	var rng = RandomNumberGenerator.new()
	return rooms[rng.randi_range(0, rooms.size()+1)]

func get_room(id):
	var rng = RandomNumberGenerator.new()
	return boss_rooms[rng.randi_range(0, boss_rooms.size()+1)]
