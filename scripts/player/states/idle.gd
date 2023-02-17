extends FSM_State


func initialize():
	print( obj.name + " current state: " + JSON.print(fsm.state_next) )
	pass

# TODO: Si el jugador presiona izq + der a la vez hay un bucle raro, solucionar
func run( _delta ):
	if Input.is_action_just_pressed( "k_left" ) or \
		Input.is_action_just_pressed( "k_right" ):
			fsm.state_next = fsm.states.Walk

	obj.motion.x = lerp( obj.motion.x, 0, obj.current_friction )
	obj.motion = obj.move_and_slide( obj.motion, Vector2.UP )
	
