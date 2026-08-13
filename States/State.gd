extends Node
class_name State

#===========
# STATE MACHINE
#===========

var max_speed = 8000
var acceleration = 1000
const SPEED = 600.0

var states
var current_state



func _init():
	states = {
		"idle": IdleState,
		"walk": WalkState,
		"start": FirstStateStart,
		"second": SecondState,
		"third": ThirdState,
		"fourth": FourthState,
		"victory": FifthStateVictory,
	}
	
func change_state(new_state_name):
	if get_child_count() != 0: 
		get_child(0).queue_free()
	current_state = states.get(new_state_name).new()
	current_state.name = new_state_name
	add_child(current_state)
