class_name RoomDataHolder

const EMTPY = 0

var starting_rooms = ["StartingRoom","StartingRoom"]
var rooms = ["Room1","Room1"] 
var boss_rooms = ["Room1","Room1"] 

var rng = RandomNumberGenerator.new()

func get_starting_room():
	return -1
#	return -100 rng.randi_range(0, starting_rooms.size()-1)

func get_random_room():
	return rng.randi_range(0, rooms.size())-1

func get_boss_room():
	return -100 - rng.randi_range(0, boss_rooms.size())-1

func load_room_by_id(id:int):
	if id == 0:
		return null;
	
	var res = null
	if id>0:
		res = starting_rooms[id]
	elif id == -1:
		res = starting_rooms[1];
	elif id < -100:
		id = (-id)%100
		res = boss_rooms[id]
	return load("res://Rooms/" + res + ".tscn").instance()
