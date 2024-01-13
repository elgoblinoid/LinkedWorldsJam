extends Area2D

@export var player : CharacterBody2D
var won : bool = false

func _on_body_entered(body):
	if body == player:
		won = true
