extends Node2D

const ROOM_SPREAD = 800
const SIZE = 50
const MAX_DIST = 1.5

var EMPTY_ROOM = 0

export var ROOMS : int = rand_range(8,12)

var rng = RandomNumberGenerator.new()
var roomDataHolder = RoomDataHolder.new()
var rooms = []
var map = []
var corridors = []

func _ready():
	rng.randomize()
	
	generate_map()
	spawn_rooms()
	set_room_connections()


func generate_map():
	map = resize(SIZE, SIZE)
	rooms = resize(SIZE, SIZE)
	
	var start : Vector2 = Vector2(SIZE/2, SIZE/2);
	set_map(start, -1)
	var cur_rooms = 1
	
	# start of random walk 
	while(cur_rooms<ROOMS):
		var pos = get_random_empty_pos() # where to start
		var direction = get_random_direction() # where to go
		var dist = rng.randi_range(1, MAX_DIST) # how far to go
		var max_rooms = dist+cur_rooms
		# moving in random direction
		# while not maxed out rooms
		while (cur_rooms <= max_rooms):
			pos = pos+direction
			# until hit another room
			if(get_map(pos) != EMPTY_ROOM):
				# with a small chance create corridor between them
				# and start again
				if(randf()<0.5):
					corridors.append([pos, pos-direction])
					break
			# create a room
			var random_room = roomDataHolder.get_random_room()
			corridors.append([pos, pos-direction])
			set_map(pos, random_room)
			cur_rooms += 1

func set_room_connections():
	for corridor in corridors:
		var one = get_room(corridor[0])
		var two = get_room(corridor[1])
		
		var dir_one : Vector2 = (one.global_position-two.global_position)
		var dir_two = dir_one.rotated(PI)
		var exit_1 = one.get_exit(dir_two)
		var exit_2 = two.get_exit(dir_one)
		RoomExit.connect_exits(exit_1, exit_2)
	
#	for i in range(SIZE-1):
#		for j in range(SIZE-1):
#			var pos = Vector2(i,j)
#			var id = get_map(pos)
#			if (id==EMPTY_ROOM):
#				continue
#			var target_poss = get_room_by_pos(pos)
#
#			var one = get_room(pos)
#
#			for target_pos in target_poss:
#				var two = get_room(target_pos)
#
#				var dir_one : Vector2 = (pos-target_pos)
#				var dir_two = dir_one.rotated(PI)
#				var exit_1 = one.get_exit(dir_two)
#				var exit_2 = two.get_exit(dir_one)
#				RoomExit.connect_exits(exit_1, exit_2)

func spawn_rooms():
	for i in range(SIZE-1):
		for j in range(SIZE-1):
			var pos = Vector2(i,j)
			var id = get_map(pos)
			if(id == EMPTY_ROOM):
				continue
			
			var room = roomDataHolder.load_room_by_id(id)
			self.add_child(room)
			room.position = pos*ROOM_SPREAD
			set_room(pos, room)

func get_room_by_pos(pos):
	var res = []
	for x in corridors:
		if(x[0] == pos):
			res.append(x[1])
		elif (x[1]==pos):
			res.append(x[0])
		else:
			continue
	return res

func get_random_direction():
	var r = rng.randi_range(0,3)
	match r:
		0:
			return Vector2.RIGHT
		1:
			return Vector2.DOWN
		2:
			return Vector2.LEFT
		3:
			return Vector2.UP

func set_map(pos, val):
	map[pos.x][pos.y] = val

func get_map(pos):
	return map[pos.x][pos.y]
	
func set_room(pos, val):
	rooms[pos.x][pos.y] = val

func get_room(pos):
	return rooms[pos.x][pos.y]

func get_random_empty_pos():
	var random_pos = null
	while random_pos==null:
		var pos = Vector2(rng.randi_range(0,SIZE-1),rng.randi_range(0,SIZE-1))
		if (get_map(pos)!=EMPTY_ROOM):
				random_pos=pos
	return random_pos

func resize(i,j):
	var res = []
	for _i in range(i):
		var line = []
		for _j in range(j):
			line.append(EMPTY_ROOM)
		res.append(line)
	return res
