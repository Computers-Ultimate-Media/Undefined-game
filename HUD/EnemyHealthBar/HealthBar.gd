extends Control

onready var health_bar = $HealthBar

func _on_health_updated(health, amount):
	health_bar.value = health
	
func _on_max_health_updated(max_health):
	health_bar.max_value = max_health

func _display_health_bar(state: bool):
	if(state):
		$HealthBar.visible = true
		$DisplayTimer.start(3)

func _on_DisplayTimer_timeout():
	$HealthBar.visible = false
