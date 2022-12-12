extends DungeonRoom

func _ready() -> void:
	enemiesToSpawn = []
	._ready()
	yield(get_tree().create_timer(0.00000005), "timeout")
	setDoors(true)
	
	room_state = roomState.CLEARED
