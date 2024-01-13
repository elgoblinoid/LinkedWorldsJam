extends State

func enter_state():
	player_sprite.play("switch")
	player.set_velocity(Vector2(0,0))

func physics_process(delta):
	if player.position.y > -200:
		player.velocity.y = -300
	else:
		player.velocity.y = 0
	player.move_and_slide()
