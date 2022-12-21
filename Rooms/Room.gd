extends Node2D
class_name DungeonRoom

enum roomState {UNVISITED, ENEMIES, CLEARED, HUB, BOSS, SHOP}

onready var exits =  $RoomExits.get_children()
onready var enemies = get_node("%Enemies")
var room_state = roomState.UNVISITED 

var enemiesToSpawn = [
		[load("res://Enemy/Enemy.tscn"), 3]
	]

func spawn_Enemies():
	
	
	var random = RandomNumberGenerator.new()
	for enemy in enemiesToSpawn:
		for i in enemy[1]:
			var instance = enemy[0].instance()
			enemies.call_deferred("add_child", instance)
			instance.connect("enemy_death", self, "on_enemy_death")
			instance.position = Vector2(0,random.randi_range(0, 100)) 

func on_enemy_death():
	var enemies_count = $Enemies.get_children().size() - 1
	if enemies_count == 0:
		on_cleared()

func on_cleared():
	setDoors(true)

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
		roomState.HUB:
			pass
			
	visible = true
	pass

func _on_RoomArea_body_exited(body:KinematicBody2D):
	if (not body.name.begins_with("Player")):
		return
	visible = false

func setDoors(state:bool):
		for exit in exits:
#			exit.state = state
			exit.set_state(state)

const EXIT_ERROR = 0.1
func get_exit(dir : Vector2):
	dir = dir.normalized()
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

func _ready() -> void:
#	self.visible = false
	pass
