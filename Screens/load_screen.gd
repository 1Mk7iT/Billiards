extends Node2D

var timer: Timer
var simultaneous_scene = preload("res://Screens/MainMenu.tscn").instantiate()

func _ready() -> void:
	timer = Timer.new()
	add_child(timer)
	# 5 секунд
	timer.wait_time = 5.0
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)
	timer.start()

func _on_timer_timeout() -> void:
	# Додати нову сцену
	get_tree().root.add_child(simultaneous_scene)
	# Видалити поточну сцену
	self.queue_free()
