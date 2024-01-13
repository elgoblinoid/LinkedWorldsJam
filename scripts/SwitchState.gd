extends State

@export var idle_state : State

func enter_state():
	player_sprite.play("switch")
	player.set_velocity(Vector2(0,0))
	$SwitchNoise.play()

func physics_process(delta):
	if player.change_state_now == 3:
		if player.position.y > -200:
			player.velocity.y = -300
		else:
			player.velocity.y = 0
	elif player.change_state_now == 0:
		if not player.is_on_floor():
			player.velocity.y += player.gravity * delta
		else:
			next_state = idle_state
	player.move_and_slide()
