extends ColorRect

export var title = "title_"
export var menu_num = 0

func _ready():
	$Label.text = title

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		self.on_click()

func on_click():
	match menu_num:
		0:
			get_tree().change_scene("res://main.tscn")
		1:
			print("clown")
		2:
			get_tree().quit()
