extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var num_of_rooms = 2
#export var cull = 0
export var cull = 0.5
export var hspread = 00
#export var hspread = 200
var rng = RandomNumberGenerator.new()



# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	
	generate_map()


func generate_map():
	clear_map()
#	fill_map()
	
	var roomData = RoomDataHolder.new()
 
	create_placeholders(roomData)
	yield(get_tree().create_timer(1), 'timeout')
	stabilize_placeholders()
	
	create_rooms(roomData)

	var room_positions = get_room_positions()
	
	yield(get_tree(), 'idle_frame')
	var path = find_path(room_positions)
	create_paths(path)

func create_paths(path:AStar2D) -> void:
	var visited_rooms = []
	for node_id in path.get_points():
		if node_id in visited_rooms:
			continue
		
		visited_rooms.append(node_id)
		var room_1 = find_room_at_point(path.get_point_position(node_id))
		for conn_id in path.get_point_connections(node_id):
			print_debug(path.get_point_position(conn_id))
			var room_2 = find_room_at_point(path.get_point_position(conn_id))
			draw_path_between_rooms(room_1, room_2)
		
	var tilemap : TileMap = get_node("%CorridorsTileMap")
	tilemap.update_bitmask_region(Vector2(-10000,-10000),Vector2(+10000,+10000))
	pass

const width = 2

func draw_path_between_rooms(room_1, room_2):
	var exit_1 = choose_exit(room_1, room_2.position)
	var exit_2 = choose_exit(room_2, room_1.position)
	
	var tilemap : TileMap = get_node("%CorridorsTileMap")
	
	var pos_1 = exit_1.global_position
	var pos_2 = exit_2.global_position
	
	carve_path(pos_1, pos_2)

const FLOOR = 5
const WALL = 4
func carve_path(pos1, pos2):
	var Map : TileMap = get_node("%CorridorsTileMap")
	
	pos1 = Map.world_to_map(pos1)
	pos2 = Map.world_to_map( pos2)
	
	#Carve a path between 2 points
	var x_diff = sign(pos2.x - pos1.x)
	var y_diff = sign(pos2.y - pos1.y)
	if x_diff == 0:
		x_diff = pow(-1.0, randi() % 2)
	if y_diff == 0: 
		y_diff = pow(-1.0, randi() % 2)
	#choose either x/y or y/x
	var x_y = pos1
	var y_x = pos2
	if (randi() % 2) > 0:
		x_y = pos2
		y_x = pos1
	for x in range(pos1.x, pos2.x, x_diff):
		Map.set_cell(x, x_y.y, FLOOR)
		Map.set_cell(x, x_y.y - y_diff, FLOOR) #widen corridor up
		Map.set_cell(x, x_y.y + y_diff, FLOOR) #widen corridor down
	for y in range(pos1.y, pos2.y, y_diff):
		Map.set_cell(y_x.x, y, FLOOR)
		Map.set_cell(y_x.x - x_diff, y, FLOOR) #widen corridor up
		Map.set_cell(y_x.x + x_diff, y, FLOOR) #widen corridor down

func choose_exit(room, target:Vector2):
	var exits = room.get_node("RoomExits").get_children()
	
	var closest_exit = exits[0]
	var closest_dst = dst_from_exit(closest_exit, target)
	
	for exit in exits:
		var dst = dst_from_exit(exit, target)
		if  dst < closest_dst:
			closest_exit = closest_exit
			closest_dst = dst
	return closest_exit

func dst_from_exit(exit, target:Vector2):
	return (exit.global_position - target).length()

func find_room_at_point(pos:Vector2):
	var POS_ERROR = 10
	for room in self.get_children():
		if((room.position - pos ).length()<POS_ERROR):
			return room
	return null

func create_placeholders(roomData):
	var roomHolder : PackedScene = load("res://Map/generatedRoomBody.tscn")
		
	for i in range(num_of_rooms):
		# select random room layout
		var room = create_random_holder(roomData, roomHolder)
		spawn_to_map(room)

func find_room(location : Vector2):
	for room in self.get_children():
		if(room.position == location):
			return room
	return null

func spawn_to_map(room):
	var starting_pos = Vector2(rand_range(-hspread, hspread), 0)
	self.add_child(room)
	self.get_children().back().position = starting_pos

func create_rooms(roomData:RoomDataHolder):
	for placeHolder in self.get_children():
		var current_roomData : RoomData = roomData.rooms[placeHolder.prefabIndex]
		var pos = placeHolder.position
		placeHolder.queue_free()
		self.add_child(current_roomData.room.instance())
		var current_room : Node2D = self.get_children().back()
		current_room.position = pos
	
	print_debug("Room created")
	pass

func create_random_holder(roomData, roomHolderScene):
	var selected_prefab = rng.randi_range(0, roomData.rooms.size()-1)
	var roomPrefab : RoomData  = roomData.rooms[selected_prefab]
	var room = roomHolderScene.instance()
	room.imitatePrefab(roomPrefab.size, selected_prefab)
	return room

func draw_path():
	pass

func stabilize_placeholders():
	# cull excess rooms	
	for room in self.get_children():
		if randf() < cull:
			room.queue_free()
		else:
			room.mode = RigidBody2D.MODE_STATIC

const grid_size = 16
func get_room_positions() -> Array:
	var positions = []
	for room in self.get_children():
		var rounded_x = round(room.position.x / grid_size)*grid_size
		var rounded_y = round(room.position.y / grid_size)*grid_size
		positions.append(Vector2(rounded_x,rounded_y))
	return positions

func find_path(room_positions) -> AStar2D:
	return find_mst(room_positions)
	
func find_mst(nodes) -> AStar2D:
	# Prim's algorithm
	# Given an array of positions (nodes), generates a minimum
	# spanning tree
	# Returns an AStar object
	
	# Initialize the AStar and add the first point
	var path = AStar2D.new()
	path.add_point(path.get_available_point_id(), nodes.pop_front())
	
	# Repeat until no more nodes remain
	while nodes:
		var min_dist = INF  # Minimum distance so far
		var min_p = null  # Position of that node
		var p = null  # Current position
		# Loop through points in path
		for p1 in path.get_points():
			p1 = path.get_point_position(p1)
			# Loop through the remaining nodes
			for p2 in nodes:
				# If the node is closer, make it the closest
				if p1.distance_to(p2) < min_dist:
					min_dist = p1.distance_to(p2)
					min_p = p2
					p = p1
		# Insert the resulting node into the path and add
		# its connection
		var n = path.get_available_point_id()
		path.add_point(n, min_p)
		path.connect_points(path.get_closest_point(p), n)
		# Remove the node from the array so it isn't visited again
		nodes.erase(min_p)
	return path

func clear_map():
	for c in get_children():
		c.queue_free()
