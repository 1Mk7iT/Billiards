extends Node2D

var balls = ["ball1", "ball2", "ball3", "ball4", "ball5", "ball6", "ball7", "ball9", "ball10", "ball11", "ball12", "ball13", "ball14", "ball15"]  # Імена нод м'ячів на сцені
var ball8 = "ball8"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shuffle_array(balls)
	balls.insert(4, ball8)
	calculate_position(100,250,0.1)
	pass # Replace with function body.

# Функція перемішування масиву
func shuffle_array(array):
	for i in range(array.size() - 1, 0, -1):
		var j = randi() % (i + 1)
		# Використовуємо тимчасову змінну для обміну значеннями
		var temp = array[i]
		array[i] = array[j]
		array[j] = temp
	return array

func calculate_position(x0 := 0, y0 := 0, gap := 0.1):
	var radius = 10
	var d = 2 * radius + gap  # Відстань між центрами кіл
	var n_row = 5
	var ball_index = 0  # Індекс для вибору м'яча із списку
	var total_balls_position = Vector2.ZERO  # Сума всіх позицій для центру трикутника
	var ball_count = 0  # Лічильник м'ячів

	for i in range(n_row):
		for j in range(i + 1):
			# Розрахунок координат з урахуванням повернення трикутника вліво
			var x = x0 + i * (d * sqrt(3) / 2)
			var y = y0 + j * d - (i * d / 2)
			# Якщо є ще м'ячі у списку, розміщуємо їх
			if ball_index < balls.size():
				var ball = get_node(balls[ball_index])
				ball.position = Vector2(x, y)
				total_balls_position += ball.position  # Додаємо позицію для середнього значення
				ball_index += 1
				ball_count += 1
			else:
				break  # Виходимо, якщо м'ячів недостатньо для повного трикутника
