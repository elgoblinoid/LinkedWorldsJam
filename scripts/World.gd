extends Node2D

#0=behind, 1=active, 2=front
@export var world_order : int
@export var world_tiles : TileMap

var max_height : int = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func remove_collision():
	world_tiles.tile_set.set_physics_layer_collision_layer(0,0)

func place_active():
	max_height = 0
	self.set_modulate(Color(1,1,1,1))
	world_tiles.tile_set.set_physics_layer_collision_layer(0,1)
	self.set_z_index(0)
	
func place_front():
	max_height = 100
	self.set_modulate(Color(0.2,0.2,0.2,1))
	world_tiles.tile_set.set_physics_layer_collision_layer(0,0)
	self.set_z_index(10)
	
func place_back():
	max_height = -100
	self.set_modulate(Color(0.2,0.2,0.2,1))
	world_tiles.tile_set.set_physics_layer_collision_layer(0,0)
	self.set_z_index(-10)
