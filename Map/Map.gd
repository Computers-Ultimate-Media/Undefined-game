extends Node2D


export var num_of_rooms = 2
var rng = RandomNumberGenerator.new()
var roomDataHolder = RoomDataHolder.new()


func _ready():
	rng.randomize()
	
	generate_map()

const ROOM_SPREAD = 500
func generate_map():
	
	var room = create_starting_room()
	for i in num_of_rooms:
		
	
	
func create_starting_room():
	var room = load_room(roomDataHolder.starting_room)
	room = room.instance()
	room.position = Vector2.ZERO
	room.name = "StartingRoom"
	
	return room
	

func load_room(res:String) -> PackedScene:
	return load("Rooms/"+res+".tscn")
