class_name RoomPlaceholder
extends RigidBody2D

export var size = Vector2(0,0)
export var prefabIndex = -1


func imitatePrefab(_size:Vector2, _prefabIndex:int):
#	self.
	size = _size
	prefabIndex = _prefabIndex
	
	var shape = RectangleShape2D.new()
	shape.custom_solver_bias = 1
	shape.extents = size
	$CollisionShape2D.shape = shape
	$CollisionShape2D.position = -size 
	
func _draw():
#	draw_rect(Rect2(Vector2(size.x,size.y), size), Color(1,0,0,0.5))
	pass
#
func _process(delta):
	fix()

func _integrate_forces(state):
	fix()
	
func _physics_process(delta):
	fix()
	
func fix():
	$CollisionShape2D.position = Vector2.ZERO
	$CollisionShape2D.rotation = 0
	rotation = 0
	
