extends Node2D

@export var player : CharacterBody2D

@export var World1 : Node2D
@export var World2 : Node2D
@export var World3 : Node2D

@export var Background1 : Sprite2D
@export var Background2 : Sprite2D
@export var Background3 : Sprite2D
@export var BlackBackground : ColorRect
@export var StartText : Sprite2D
@export var LoseText : Sprite2D
@export var WinText : Sprite2D
@export var WinPortal : Area2D
@export var TimeLabel : Label

#0=no 1-4 stages
var switching : int = 0

#0=start text, 1=live, 2=end
var game_state : int = 0

# 3,1,2 back to front start
var current_world = 1
var new_world = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	World1.place_active()
	World1.position.y = World1.max_height
	World2.place_front()
	World2.position.y = World2.max_height
	World3.place_back()
	World3.position.y = World3.max_height
	new_world_background()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if game_state == 0:
		if Input.is_action_just_pressed("jump"):
			StartText.set_visible(false)
			game_state = 1
			TimeLabel.start_timer()
	elif game_state == 1:
		player.physics_process(delta)
		if player.check_to_switch() == 1:
			switch_front()
		elif player.check_to_switch() == 2:
			switch_back()
		if switching == 1:
			World1.remove_collision()
			World2.remove_collision()
			World3.remove_collision()
			WinPortal.set_collision_mask_value(2,false)
			raise_black_background()
			lower_worlds()
		if switching == 2:
			raise_worlds()
		if switching == 3:
			lower_black_background()
		if switching == 4:
			BlackBackground.set_visible(false)
			switching == 0
			player.set_change_switch(0)
			if current_world == 1:
				WinPortal.set_collision_mask_value(2,true)
		#dead
		if player.position.y > 200:
			$LoseSound.play()
			LoseText.set_visible(true)
			game_state = 2
			player.position.y = 200
		elif WinPortal.won:
			win()
	if game_state == 2:
		TimeLabel.stop_timer()
		BlackBackground.set_visible(false)
		if Input.is_action_just_pressed("jump"):
			get_tree().reload_current_scene()
			
func win():
	$WinSound.play()
	WinText.set_visible(true)
	game_state = 2

func new_world_background():
	#Set active to -100, others to -101
	if current_world == 1:
		Background1.set_visible(true)
		Background2.set_visible(false)
		Background3.set_visible(false)
	elif current_world == 2:
		Background1.set_visible(false)
		Background2.set_visible(true)
		Background3.set_visible(false)
	elif current_world == 3:
		Background1.set_visible(false)
		Background2.set_visible(false)
		Background3.set_visible(true)

func switch_front():
	player.set_change_switch(3)
	if current_world == 1:
		new_world = 2
	elif current_world == 2:
		new_world = 3
	else:
		new_world = 1
	switching = 1
	BlackBackground.set_visible(true)
	
func switch_back():
	player.set_change_switch(3)
	if current_world == 1:
		new_world = 3
	elif current_world == 2:
		new_world = 1
	else:
		new_world = 2
	switching = 1
	BlackBackground.set_visible(true)

func raise_black_background():
	TimeLabel.white_text()
	if BlackBackground.position.y > -200:
		BlackBackground.position.y -= 15
		
func lower_black_background():
	if BlackBackground.position.y < 200:
		BlackBackground.position.y += 15
	else:
		switching = 4
		
func lower_worlds():
	if World1.position.y < 300:
		if current_world == 2:
			World1.position.y += 12
		elif current_world == 3:
			World1.position.y += 8
		else:
			World1.position.y += 10
	if World2.position.y < 300:
		if current_world == 3:
			World2.position.y += 12
		elif current_world == 1:
			World2.position.y += 8
		else:
			World2.position.y += 10
	if World3.position.y < 300:
		if current_world == 1:
			World3.position.y += 12
		elif current_world == 2:
			World3.position.y += 8
		else:
			World3.position.y += 10
	if World1.position.y>=300 and World2.position.y>=300 and World3.position.y>=300:
		switching = 2
		current_world=new_world
		if current_world==1:
			switch_world_1()
		elif current_world==2:
			switch_world_2()
		else:
			switch_world_3()

func switch_world_1():
	World1.place_active()
	World2.place_front()
	World3.place_back()
	
func switch_world_2():
	World2.place_active()
	World3.place_front()
	World1.place_back()
	
func switch_world_3():
	World3.place_active()
	World1.place_front()
	World2.place_back()

func raise_worlds():
	#world1
	if World1.position.y > World1.max_height:
		if current_world == 2:
			World1.position.y -= 12
		elif current_world == 3:
			World1.position.y -= 8
		else:
			World1.position.y -= 10
	if World1.position.y < World1.max_height:
		World1.position.y = World1.max_height
	#world2
	if World2.position.y > World2.max_height:
		if current_world == 3:
			World2.position.y -= 12
		elif current_world == 1:
			World2.position.y -= 8
		else:
			World2.position.y -= 10
	if World2.position.y < World2.max_height:
		World2.position.y = World2.max_height
	#world3
	if World3.position.y > World3.max_height:
		if current_world == 1:
			World3.position.y -= 12
		elif current_world == 2:
			World3.position.y -= 8
		else:
			World3.position.y -= 10
	if World3.position.y < World3.max_height:
		World3.position.y = World3.max_height
	#final
	if World1.position.y==World1.max_height and World2.position.y==World2.max_height and World3.position.y==World3.max_height:
		new_world_background()
		switching=3
		if current_world == 2:
			TimeLabel.black_text()
		else:
			TimeLabel.white_text()
