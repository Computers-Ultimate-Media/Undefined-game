extends Node2D
class_name DungeonRoom

enum roomState {UNVISITED, ENEMIES, CLEARED}


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var exits = get_tree().get_nodes_in_group("exit")
onready var enemies = get_node("%Enemies")
var room_state = roomState.UNVISITED 

func spawn_Enemies():
	print_debug("spawned enemies")

	var enemiesToSpawn = [
		[load("res://Enemy/Enemy.tscn"), 3]
	]
	
	var random = RandomNumberGenerator.new()
	for enemy in enemiesToSpawn:
		for i in enemy[1]:
			var instance = enemy[0].instance()
			enemies.call_deferred("add_child", instance)
			instance.position = Vector2(0,random.randi_range(0, 100)) 

# TODO: build programmatically
func on_Enemy_death():
	
	var enemies = $Enemies.get_children()
	if enemies.empty():
		setDoors(true)
	else:
		setDoors(false)
	pass

func _on_RoomArea_body_entered(body:KinematicBody2D):
	if (not body.name.begins_with("Player")):
		return
	
	match room_state:
		roomState.UNVISITED:
			spawn_Enemies()
			setDoors(false)
			room_state = roomState.ENEMIES
			pass
		roomState.ENEMIES:
			pass
		roomState.CLEARED:
			pass
	pass

func setDoors(state:bool):
		for exit in exits:
			exit.state = state

var EXIT_ERROR = 0.1
func get_exit(dir : Vector2):
	var exit
	if (dir-Vector2.UP).length()<EXIT_ERROR:
			exit = "UP"
	elif (dir-Vector2.RIGHT).length()<EXIT_ERROR:
			exit = "RIGHT"
	elif (dir-Vector2.DOWN).length()<EXIT_ERROR:
			exit = "DOWN"
	elif (dir-Vector2.LEFT).length()<EXIT_ERROR:
			exit = "LEFT"
	
	exit = get_node("RoomExits/"+exit)
	return exit
