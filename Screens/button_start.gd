extends Button

var simultaneous_scene = preload("res://Screens/LevelMenu.tscn").instantiate()

func _on_pressed() -> void:
	get_tree().root.add_child(simultaneous_scene)
	self.queue_free()
	pass
