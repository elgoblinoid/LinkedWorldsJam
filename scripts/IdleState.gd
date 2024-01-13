extends State

@export var run_state : State
@export var jump_state : State
@export var switch_state : State

func physics_process(delta):
	#Fall
	if not player.is_on_floor():
		player.velocity.y += player.gravity * delta
		next_state = jump_state
		
	#Run
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		player.velocity.x = direction * player.SPEED
		next_state = run_state
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
		if Input.is_action_just_pressed("ui_down"):
			next_state = switch_state
			message = "switch_front"
		elif Input.is_action_just_pressed("ui_up"):
			next_state = switch_state
			message = "switch_back"
		
	#Jump
	if Input.is_action_just_pressed("ui_accept") and player.is_on_floor():
		player.velocity.y = player.JUMP_VELOCITY
		next_state = jump_state
	
	player.move_and_slide()

func enter_state():
	player_sprite.play("idle")

func exit_state():
	message = ""
