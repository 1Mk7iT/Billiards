extends RigidBody2D

var number = self.name.to_int()
var type

func _process(delta: float) -> void:
	if (number <=9 and number != 8):
		type = "linest"
	else:
		type = "fullest"
	pass

func getType():
	return type
	pass
func getNumber():
	return number
	pass
