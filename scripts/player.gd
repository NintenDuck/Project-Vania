extends KinematicBody2D

export var velocity 		= 0
export var max_velocity 	= 0
export var friction 		= 0
export var jump_force 		= 0

var input_direction = 1

enum states {
	IDLEING,
	WALKING,
	JUMPING,
	SLIDING,
}

var current_state = states.IDLEING

func _process(delta):
	match current_state:
		states.IDLEING:
			print(get_input_direction())
		states.WALKING:
			print("Walking")
		states.JUMPING:
			print("Jumping")
		states.SLIDING:
			print("Sliding")



func get_input_direction():
	""" Esta funcion regresara la actual direccion que dio el usuario """
	input_direction = int(Input.is_action_pressed("k_right")) - int(Input.is_action_pressed("k_left"))
	return input_direction


# func move():
	
