extends Node2D

@export var noise_height_text : NoiseTexture2D
var noise : Noise

var width : int = 100
var heigth : int = 100
@onready var tile_map = $TileMap

var source_id = 3
var water_atlas = Vector2i(12,0)
var land_atlas = Vector2i(0,0)

func generate_world():
	for x in range(-width/2, width/2):
		for y in range(-heigth/2, heigth/2):
			var noise_val = noise.get_noise_2d(x,y)
			
			if noise_val < 0.0:
				tile_map.set_cell(0, Vector2i(x,y),source_id,water_atlas)
			elif noise_val > 0.0:
				tile_map.set_cell(0, Vector2i(x,y),source_id,land_atlas)


# Called when the node enters the scene tree for the first time.
func _ready():
	noise = noise_height_text.noise
	generate_world()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
