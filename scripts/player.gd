extends CharacterBody2D

@export var state_machine : PlayerStateMachine
#0=no, 1=front, 2=back, 3=wait
var change_state_now : int = 0

const SPEED = 200.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func physics_process(delta):
	state_machine.physics_process(delta)
	change_state_now = state_machine.check_to_switch()
	
func check_to_switch():
	return change_state_now
	
func set_change_switch(new_change_state_now):
	change_state_now = new_change_state_now
