extends Panel

export var title = "title_"
export var menu_num = 0
var new_style

func _ready():
	new_style = StyleBoxFlat.new()
	new_style.set_corner_radius_all(10)
	new_style.set_bg_color(Color("#c6251e1e"))
	self.set('custom_styles/panel', new_style)
	$Label.text = title

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		self._on_click()

func _on_click():
	get_tree().paused = false
	
	match menu_num:
		0:
			get_tree().change_scene("res://main.tscn")
		1:
			get_tree().change_scene("res://HUD/SettingsScreen/SettingsScreen.tscn")
		2:
			get_tree().quit()
		3:
			get_tree().change_scene("res://HUD/StartScreen/StartScreen.tscn")
		4:
			get_tree().root.get_node("main/GamePause").visible = false


func _on_Area2D_mouse_entered():
	new_style.set_bg_color(Color("#a0986969"))

func _on_Area2D_mouse_exited():
	new_style.set_bg_color(Color("#c6251e1e"))
