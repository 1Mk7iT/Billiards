extends Node2D

@export var white_ball: Node2D
@export var cue_skins: Array[String] = ["res://Img/cues/cue1.png", "res://Img/cues/cue2.png"]
var skinID = 1
var cue_texture: Sprite2D
var distanceToBall = 300
var ballTouchIsHolded = false
var wasPulledBack = false
var direction
var cueHeight = 150
var minCueDistance = cueHeight
var maxCueDistance = cueHeight * 3
var is_ball_selected = false

func _ready() -> void:
	create_cue()
	if white_ball == null:
		print("Error: white_ball is not assigned!")
	if cue_texture == null:
		print("Error: cue_texture is not created!")

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			var query = PhysicsPointQueryParameters2D.new()
			query.position = get_global_mouse_position()
			var space_state = get_world_2d().direct_space_state
			var result = space_state.intersect_point(query)
			
			is_ball_selected = false
			for collision in result:
				if collision.collider == white_ball:
					is_ball_selected = true

			if not is_ball_selected:
				ballTouchIsHolded = true
				wasPulledBack = false
		else:
			ballTouchIsHolded = false
			if wasPulledBack and distanceToBall > minCueDistance:
				print("shot")
				white_ball.linear_velocity = direction * (distanceToBall - cueHeight) * 10
				white_ball.has_been_hit = true

func _process(delta: float) -> void:
	if white_ball.linear_velocity.length() < 2.0:
		if cue_texture != null:
			cue_texture.visible = true

			if not ballTouchIsHolded:
				direction = (get_global_mouse_position() - white_ball.position).normalized()
				cue_texture.rotation = direction.angle() + (90 * (PI / 180))
				distanceToBall = cueHeight
			else:
				var current_distance = white_ball.position.distance_to(get_global_mouse_position()) + cueHeight
				if current_distance > minCueDistance and current_distance < maxCueDistance:
					distanceToBall = current_distance
					wasPulledBack = true

			cue_texture.position = white_ball.position - (direction * distanceToBall)
	else:
		if cue_texture != null:
			cue_texture.visible = false

func create_cue() -> void:
	cue_texture = Sprite2D.new()
	add_child(cue_texture)
	
	var texture_path = cue_skins[skinID]
	cue_texture.texture = load(texture_path)
