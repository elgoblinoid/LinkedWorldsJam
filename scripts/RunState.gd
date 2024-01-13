extends State

@export var idle_state : State
@export var jump_state : State

func physics_process(delta):
	#Fall
	if not player.is_on_floor():
		player.velocity.y += player.gravity * delta
		next_state = jump_state
		
	#Run
	var direction = Input.get_axis("left", "right")
	if direction:
		player.velocity.x = direction * player.SPEED
		if direction > 0:
			player_sprite.flip_h = false
		else:
			player_sprite.flip_h = true
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
		next_state = idle_state
		
	#Jump
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		player.velocity.y = player.JUMP_VELOCITY
		next_state = jump_state
	
	player.move_and_slide()

func enter_state():
	player_sprite.play("run")
