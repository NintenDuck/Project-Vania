extends KinematicBody2D

export(int) var VELOCITY 		= 0
export(int) var MAX_VELOCITY 	= 0
export(float) var FRICTION 		= 0.0
export var JUMP_FORCE 			= 0
export(float) var CUT_HEIGHT	= 0.0
export(int) var GRAVITY			= 0

var motion 						= Vector2.ZERO
var double_jump_powerup:bool	= true
var jump_counter:int			= 0

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
			check_jump()
			apply_friction()
			if not is_on_floor():
				apply_gravity(delta)
			move()
		states.WALKING:
			apply_horizontal_force(get_input_vector(), delta)
			check_jump()
			move()
			if not is_on_floor():
				change_state_to(states.JUMPING)
		states.JUMPING:
			if is_on_floor():
				change_state_to(states.IDLEING)
			
			apply_horizontal_force(get_input_vector(), delta)
			apply_gravity(delta)
			check_jump()
			move()
		states.SLIDING:
			print("Sliding")


func _input(event):
	if event.is_action_released("k_jump"):
		if motion.y < 0:
			motion.y *= CUT_HEIGHT

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


func check_jump():
	if is_on_floor(): jump_counter = 0

	if is_on_floor() or jump_counter < 2:
		if Input.is_action_just_pressed("k_jump"):
			jump_counter += 1
			jump(JUMP_FORCE)

func jump(jump_force:int):
	motion.y = 0
	motion.y -= jump_force


func apply_gravity(delta):
	if is_on_floor(): return

	motion.y += GRAVITY * delta


func move():
	motion = move_and_slide( motion, Vector2.UP, true )
	motion.x = clamp( motion.x, -MAX_VELOCITY, MAX_VELOCITY )
	# print( motion.y )
