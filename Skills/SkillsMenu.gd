extends CanvasLayer

func _ready():
	generate_menu()

func generate_menu():
	var skills =  Utils.read_from_JSON("res://Assets/JSON/Player/Skills/skill.json")
	for category in skills:
		var loaded_categories = preload("res://Skills/Categories.tscn").instance()
		loaded_categories.title = category
		var category_control = Control.new()
		category_control.add_child(loaded_categories)
		$ScrollContainer/VBoxContainer.add_child(category_control)
		var hbox = HBoxContainer.new()
		hbox.add_constant_override("separation", 170)
		for skill in skills[category]:
			var control = Control.new()
			var new_card = preload("res://Skills/Card.tscn").instance()
			new_card.title = skill.name
			new_card.point = str(skill.point)
			new_card.color = Color.blueviolet
			new_card.set_size(Vector2(150, 50))
			control.add_child(new_card)
			hbox.add_child(control)
		$ScrollContainer/VBoxContainer.add_child(hbox)
	var control_empty = Control.new()
	$ScrollContainer/VBoxContainer.add_child(control_empty)	

func _on_Player_open_skills_menu():
	get_tree().paused = false
	self.visible = !(self.visible)
