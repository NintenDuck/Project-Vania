extends "res://scripts/fsm/fsm_state.gd"


func initialize():
	print( obj.name + " current state: " + JSON.print(fsm.state_next) )
	pass

func run( _delta ):
    var dir = obj.get_dir()
    var is_moving = abs( obj.get_dir() ) > 0.1

    if is_moving:
        obj.motion.x += obj.VELOCITY * dir
        obj.motion = obj.move_and_slide( obj.motion, Vector2.UP )
        obj.motion.x = clamp( obj.motion.x, -obj.MAX_VELOCITY, obj.MAX_VELOCITY )
    else:
        fsm.state_next = fsm.states.Idle

