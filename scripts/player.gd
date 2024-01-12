extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#0=idle, 1=run, 2=jump
var player_state : int = 0


func _physics_process(delta):
	
	player_state = 0
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		player_state = 2

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if player_state == 0:
			player_state = 1
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	updatePlayerAnimation()

	move_and_slide()

func updatePlayerAnimation():
	if player_state == 1:
		$PlayerSprite.play("run")
	if player_state == 2:
		$PlayerSprite.play("jump")
	else:
		$PlayerSprite.play("idle")
