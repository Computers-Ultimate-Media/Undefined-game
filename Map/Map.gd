extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var num_of_rooms = 20
export var cull = 0.5
export var hspread = 00
#export var hspread = 200



# Called when the node enters the scene tree for the first time.
func _ready():
	for c in get_children():
		c.queue_free()

	generate_map()


func generate_map():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var roomData = RoomDataHolder.new()
	var roomHolder : PackedScene = load("res://Map/generatedRoomBody.tscn")

	# create physics objects in place of rooms
	# for them to be sorted out by physicsEngine 2D
 
	for i in range(num_of_rooms):
		# select random room layout
		var prefabIndex = rng.randi_range(0, roomData.rooms.size()-1)
		var roomPrefab : RoomData  = roomData.rooms[prefabIndex]
		
		# make map horizontally spread out
		var pos = Vector2(rand_range(-hspread, hspread), 0)	
		var room = roomHolder.instance()
		room.imitatePrefab(roomPrefab.size, prefabIndex)
		self.add_child(room)
		self.get_children().back().position = pos
	
	# let them settle	
	yield(get_tree().create_timer(1.5), 'timeout')
	
	# cull excess rooms
	var room_positions = []
	for room in self.get_children():
		if randf() < cull:
			room.queue_free()
		else:
			room.mode = RigidBody2D.MODE_STATIC
			room.position.x = round((room.position.x / 32))*32
			room.position.y = round((room.position.y / 32))*32
			room_positions.append(Vector3(room.position.x,
										  room.position.y, 
										  0))
										
	yield(get_tree(), 'idle_frame')
	# generate a minimum spanning tree connecting the rooms
	var path = find_mst(room_positions)
	

func draw_path():
	pass

func find_mst(nodes):
	# Prim's algorithm
	# Given an array of positions (nodes), generates a minimum
	# spanning tree
	# Returns an AStar object
	
	# Initialize the AStar and add the first point
	var path = AStar.new()
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

