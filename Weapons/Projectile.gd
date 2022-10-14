extends Node2D

class_name Projectile

export var weapon_owner_node_path: NodePath
export var max_damage: int
export var min_damage: int
export var critical_damage: int
export var critical_damage_chance: int
export var max_distance_shot: int = 300
export var speed: int = 95

var direction := Vector2(-1, 0) setget set_direction

var weapon_owner
onready var timer = $KillTimer

func _ready() -> void:
	timer.start(max_distance_shot / speed)
	

func attack(enemy) -> bool:
	enemy.health.damaged(max_damage)
	return true

func _physics_process(delta):
	if direction != Vector2.ZERO:
		var velocity = direction * speed

		global_position += velocity

	
func set_direction(vector: Vector2):
	direction = vector
	rotation += direction.angle()


func _on_KillTimer_timeout():
	queue_free()


func _on_Projectile_body_entered(body):
		body.queue_free()
		queue_free()
