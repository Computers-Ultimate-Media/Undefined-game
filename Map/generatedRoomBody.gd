extends RigidBody2D

var size
var prefabIndex


func imitatePrefab(_size:Vector2, _prefabIndex:int):
	size = _size
	prefabIndex = _prefabIndex
	
	var shape = RectangleShape2D.new()
	shape.custom_solver_bias = 1
	shape.extents = _size / 2
	$CollisionShape2D.shape = shape
	
#func _draw():
#	draw_rect(Rect2(position, size), Color(1,0,0,0.5))
#
func _process(delta):
	rotation_degrees = 0
#	update()

