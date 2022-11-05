class_name RoomDataHolder

var rooms = [
	RoomData.new("Room1", Vector2(512, 380), {
		top = Vector2(208,0),
		right = Vector2(432,208),
		down = Vector2(112,-384),
		bottom = Vector2(0,320),
	}),
#	RoomData.new("Room2", Vector2(700, 700), {
#		top = Vector2(256,-32),
#		right = Vector2(256,-32),
#		down = Vector2(256,-32),
#		bottom = Vector2(256,-32),
#	})
] 


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
