extends Node

class_name PlayerStateMachine

@export var current_state : State
#0=no, 1=front, 2=back
var switch_state_now : int = 0

func physics_process(delta):
	current_state.physics_process(delta)
	if switch_state_now != 0:
		switch_state_now = 0
	if current_state.next_state != null:
		if current_state.message == "switch_front":
			switch_state_now = 1
		elif current_state.message == "switch_back":
			switch_state_now = 2
		current_state.exit_state()
		current_state = current_state.next_state
		current_state.next_state = null
		current_state.enter_state()

func check_if_can_move():
	return current_state.can_move

func check_if_can_jump():
	return current_state.can_jump

func check_to_switch():
	return switch_state_now
