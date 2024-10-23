extends RigidBody2D

func _input(event):
	if event is InputEventMouseButton and event.button_index == 1:
		if event.pressed:
			# Створюємо параметри для перевірки точки
			var query = PhysicsPointQueryParameters2D.new()
			query.position = get_global_mouse_position()

			# Отримуємо стан простору для перевірки колізій
			var space_state = get_world_2d().direct_space_state
			
			# Виконуємо перевірку точки
			var result = space_state.intersect_point(query)
			
			for collision in result:
				if collision.collider == self:
					# Якщо об'єкт був натиснутий, додаємо випадковий рух
					self.linear_velocity.x = randf_range(-1000, 1000)
					self.linear_velocity.y = randf_range(-1000, 1000)
