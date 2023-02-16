extends Node
class_name FSM

var states = {}
var state_current = null
var state_next = null
var state_last = null
var obj = null

func _init( object, parent_state_nodes:Node, initial_state:Node ):
	self.obj = object
	_set_states_from_parent( parent_state_nodes )
	state_next = initial_state


func _set_states_from_parent( parent_states:Node ):
	if parent_states.get_child_count() == 0:
		return
		
	for state_node in parent_states.get_children():
		states[ state_node.name ] = state_node
		state_node.fsm = self
		state_node.obj = self.obj
	

func run_machine( delta ):
	if state_next != state_current:
		if state_current != null:
			state_current.terminate()
		state_last = state_current
		state_current = state_next
		state_current.initialize()
	
	state_current.run( delta )

	
func _terminate():
	pass
