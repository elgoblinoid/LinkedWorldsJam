extends State

@export var run_state : State
@export var idle_state : State

func physics_process(delta):
	#Fall
	if not player.is_on_floor():
		player.velocity.y += player.gravity * delta
		
	#Run
	var direction = Input.get_axis("left", "right")
	if direction:
		player.velocity.x = (direction * player.SPEED)/2
		if player.is_on_floor():
			next_state = run_state
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED/2)
		if player.is_on_floor():
			next_state = idle_state
	
	player.move_and_slide()

func enter_state():
	player_sprite.play("jump")
	$JumpNoise.play()
