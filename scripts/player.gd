extends KinematicBody2D

export(int) var VELOCITY 		= 0
export(int) var MAX_VELOCITY 	= 0
export(float) var FRICTION 		= 0.0
export var JUMP_FORCE 			= 0
export(int) var GRAVITY			= 0

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
			if get_input_vector() != 0:
				change_state_to(states.WALKING)
				return
			apply_friction()
			apply_gravity(delta)
			move()
		states.WALKING:
			apply_horizontal_force(get_input_vector(), delta)
			move()
			if not is_on_floor():
				apply_gravity(delta)
		states.JUMPING:
			print("Jumping")
		states.SLIDING:
			print("Sliding")


func change_state_to(new_state:int):
	current_state = new_state
	return new_state


func get_input_vector():
	var input_vector = int(Input.is_action_pressed("k_right")) - int(Input.is_action_pressed("k_left"))
	return input_vector


func apply_friction():
	motion.x = lerp( motion.x, 0, FRICTION )


func apply_horizontal_force(input_vector:int, delta:float):
	if input_vector != 0:
		motion.x += ( VELOCITY * input_vector ) * delta
	else:
		change_state_to( states.IDLEING )
	return motion.x


func apply_gravity(delta):
	if not is_on_floor():
		motion.y += GRAVITY * delta


func move():
	motion = move_and_slide( motion, Vector2.UP, true )
	motion.x = clamp( motion.x, -MAX_VELOCITY, MAX_VELOCITY )
	print( motion )
