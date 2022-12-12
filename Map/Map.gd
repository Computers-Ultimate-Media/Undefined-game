extends Node2D

const ROOM_SPREAD = 800
const SIZE = 50
const MAX_DIST = 1.5

const EMPTY_ROOM = 0

export var ROOMS : int = rand_range(8,12)

var rng = RandomNumberGenerator.new()
var roomDataHolder = RoomDataHolder.new()
var rooms = []
var map = []
var corridors = []

func _ready():
	rng.randomize()
	
	gen_map()
	spawn_rooms()
	set_corridors()


func gen_map():
	map = resize(SIZE, SIZE)
	rooms = resize(SIZE, SIZE)
	
	var start : Vector2 = Vector2(SIZE/2, SIZE/2);
	map[start.x][start.y] = -1
	var cur_rooms = 1
	
	# start of random walk 
	while(cur_rooms<ROOMS):
		var pos = select_random_pos() # where to start
		var direction = select_random_direction() # where to go
		var dist = rng.randi_range(1, MAX_DIST) # how far to go
		var max_rooms = dist+cur_rooms
		# moving in random direction
		# while not maxed out rooms
		while (cur_rooms <= max_rooms):
			pos = pos+direction
			# until hit another room
			if(get(pos) != EMPTY_ROOM):
				# with a small chance create corridor between them
				# and start again
				if(randf()<0.5):
					corridors.append([pos, pos-direction])
					break
			# create a room
			var random_room = select_random_room()
			corridors.append([pos, pos-direction])
			map[pos.x][pos.y] = random_room
			cur_rooms += 1

func set_corridors():
	for i in range(SIZE-1):
		for j in range(SIZE-1):
			var id = map[i][j]
			if (id==EMPTY_ROOM):
				continue
			var pos = Vector2(i,j)
			var target_poss = find_mem(i,j)
			
			var one = rooms[i][j]
			
			for target_pos in target_poss:
				var two = rooms[target_pos.x][target_pos.y]
			
				var dir_one : Vector2 = (pos-target_pos)
				var dir_two = dir_one.rotated(PI)
				var exit_1 = one.get_exit(dir_two)
				var exit_2 = two.get_exit(dir_one)
				RoomExit.connect_exits(exit_1, exit_2)

func spawn_rooms():
	for i in range(SIZE-1):
		for j in range(SIZE-1):
			var id = map[i][j]
			if(id == EMPTY_ROOM):
				continue
			
			var room
			if (Vector2(i,j)==Vector2(SIZE/2, SIZE/2)):
				room = load_room(roomDataHolder.get_starting_room())
			elif (id<0):
				room = load_room(roomDataHolder.get_room(id)) 
			else:
				room = load_room(roomDataHolder.rooms[id])
			
			self.add_child(room)
			room.position = Vector2(ROOM_SPREAD*i, ROOM_SPREAD*j)
			rooms[i][j] = room

func find_mem(i,j):
	var vec = Vector2(i,j)
	var res = []
	for x in corridors:
		if(x[0] == vec):
			res.append(x[1])
		elif (x[1]==vec):
			res.append(x[0])
		else:
			continue
	return res

func select_random_direction():
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

func set(pos, val):
	map[pos.x][pos.y] = val

func get(pos):
	return map[pos.x][pos.y]

func select_random_room():
	var id = rng.randi_range(1, roomDataHolder.rooms.size()-1)
	return id

func select_random_pos():
	var random_pos = null
	while random_pos==null:
		var pos = Vector2(rng.randi_range(0,SIZE-1),rng.randi_range(0,SIZE-1))
		if (get(pos)!=EMPTY_ROOM):
			random_pos=pos
	return random_pos

func load_room(res:String):
	return load("res://Rooms/" + res + ".tscn").instance()

func resize(i,j):
	var res = []
	for _i in range(i):
		var line = []
		for _j in range(j):
			line.append(EMPTY_ROOM)
		res.append(line)
	return res
