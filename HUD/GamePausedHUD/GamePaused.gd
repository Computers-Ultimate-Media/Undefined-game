extends CanvasLayer

var is_paused = false setget set_is_paused

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel") \
	and !get_tree().root.get_node("main/GameOver").visible \
	and !get_tree().root.get_node("main/Inventory").visible \
	and !get_tree().root.get_node("main/SkillsMenu").visible:
		self.is_paused = !is_paused
		
func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused
