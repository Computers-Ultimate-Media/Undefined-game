extends TextureProgress

func _on_health_updated(health, amount):
	self.value = health
	
func _on_max_health_updated(max_health):
	self.max_value = max_health

func _display_health_bar(state: bool):
	if(state):
		self.visible = true
		$DisplayTimer.start(3)

func _on_DisplayTimer_timeout():
	self.visible = false
