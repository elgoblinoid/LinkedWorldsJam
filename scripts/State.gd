extends Node

class_name State

@export var player_sprite : AnimatedSprite2D
@export var player : CharacterBody2D
@export var next_state : State = null
@export var message : String = ""

func enter_state():
	pass
	
func exit_state():
	pass
