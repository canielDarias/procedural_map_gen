extends Node2D

@export var noise_height_text : NoiseTexture2D
var noise : Noise

var width : int = 100
var heigth : int = 100
@onready var tile_map = $TileMap

var source_id = 3
var deep_water = Vector2i(14,0)
var water = Vector2i(12,0)
var land = Vector2i(0,0)
var sand = Vector2i(0,9)
var hill = Vector2i(6,0)
var mountain = Vector2i(10,0)

func generate_world():
	var x : float
	var y : float
	
	for w : float in range(width):
		x = floor(-width/4)*3 + floor(w/2)
		y = floor(-heigth/4) - ceil(w/2)
		
		if w == floor(0):
			print(x,",",y)
		
		for h : float in range(heigth):
			
			var noise_val = noise.get_noise_2d(x,y)
			
			if noise_val < -0.3:
				tile_map.set_cell(-1, Vector2i(x,y),source_id,deep_water)
			elif noise_val < 0.0:
				tile_map.set_cell(0, Vector2i(x,y),source_id,water)
			elif noise_val < 0.1:
				tile_map.set_cell(0, Vector2i(x,y),source_id,sand)
			elif noise_val < 0.4:
				tile_map.set_cell(0, Vector2i(x,y),source_id,land)
			elif noise_val < 0.5:
				tile_map.set_cell(0, Vector2i(x,y),source_id,hill)
			else:
				tile_map.set_cell(0, Vector2i(x,y),source_id,mountain)
			
			x += 1
			y += 1
			


# Called when the node enters the scene tree for the first time.
func _ready():
	noise = noise_height_text.noise
	generate_world()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
