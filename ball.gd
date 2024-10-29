extends RigidBody2D

var ball_name: String

func _ready():
	ball_name = name  
	add_sprite()

func add_sprite():
	var sprite_path = "res://Img/Balls/" + ball_name + ".png" 
	var sprite = Sprite2D.new()
	sprite.texture = load(sprite_path)

	# Встановлюємо розмір спрайта відповідно до розміру колізії
	var scale_factor = Vector2(30, 30) / sprite.texture.get_size()  # Задайте бажаний розмір
	sprite.scale = scale_factor

	add_child(sprite)  
