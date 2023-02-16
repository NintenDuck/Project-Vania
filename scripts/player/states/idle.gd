extends FSM_State


func initialize():
	print( obj.name + " current state: " + JSON.print(fsm.state_next) )
	pass

func run( _delta ):
	var is_moving = abs( obj.get_dir() ) > 0.1
	print( is_moving )
