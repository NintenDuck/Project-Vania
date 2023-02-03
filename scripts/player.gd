extends KinematicBody2D

export var velocity 		= 0
export var max_velocity 	= 0
export(float) var friction 	= 0.0
export var jump_force 		= 0

var motion = Vector2.ZERO

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
			print(get_input_vector())
			move()
		states.WALKING:
			print("Walking")
		states.JUMPING:
			print("Jumping")
		states.SLIDING:
			print("Sliding")



func get_input_vector():
	var input_vector = int(Input.is_action_pressed("k_right")) - int(Input.is_action_pressed("k_left"))
	return input_vector


func move():
	var input_vector = get_input_vector()
	if input_vector != 0:
		motion.x = velocity * input_vector
	else:
		motion.x = 0

	motion = move_and_slide(motion, Vector2.UP, true)
	print(motion)
