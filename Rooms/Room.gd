extends Node2D

enum roomState {UNVISITED, ENEMIES, CLEARED}


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var exits = get_tree().get_nodes_in_group("exit")
onready var enemies = get_node("%Enemies")
var room_state = roomState.UNVISITED 

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass

func spawn_Enemies():
	print_debug("spawned enemies")

	var enemiesToSpawn = [
		[load("res://Enemy/Enemy.tscn"), 10]
	]
	
	var random = RandomNumberGenerator.new()
#	var spawnPosition = ($SpawnPosition as Position2D).position
#	print_debug("spawn = "+ spawnPosition)
#	print_debug("pos = "+ position.ToString())
	for enemy in enemiesToSpawn:
		for i in enemy[1]:
			var instance = enemy[0].instance()
			enemies.call_deferred("add_child", instance)
#			enemies.add_child(instance)
#			instance.set_position(spawnPosition) 
			instance.position = Vector2(0,0)
#			(instance as Node2D).set_deferred("position",Vector2(-300,-195))
#			instance.set_deferred("position", Vector2(20,20))
#			instance.set_position(Vector2(20,20)) 

func on_Enemy_death():
	print_debug("enemy dead")
	
	var enemies = $Enemies.get_children()
	if enemies.empty():
		setDoors(true)
	else:
		setDoors(false)
	pass

func _on_RoomArea_body_entered(body:KinematicBody2D):
	print_debug(body.name)
	if( not body.name.begins_with("Player")):
		return
	
	print_debug(body)
	match room_state:
		roomState.UNVISITED:
			spawn_Enemies()
			setDoors(false)
			room_state= roomState.ENEMIES
			pass
		roomState.ENEMIES:
			print_debug("error")
			pass
		roomState.CLEARED:
			pass
	pass # Replace with function body.
		
		
func setDoors(state:bool):
		for exit in exits:
			exit.setOpen(state)