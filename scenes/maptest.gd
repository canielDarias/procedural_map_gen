extends Node2D

@export var noise_height_text : NoiseTexture2D
var noise : Noise

var width : int = 128
var heigth : int = 128
@onready var tile_map = $TileMap

#region TileSet Terrains
var source_id = 3
var grass_plains = Vector2i(0, 0)
var grass_forest_scarce = Vector2i(2, 0)
var grass_forest_deep = Vector2i(4, 0)
var grass_hill = Vector2i(6, 0)
var grass_hill_forest = Vector2i(8, 0)
var mountain = Vector2i(10, 0)
var ocean_shallow = Vector2i(12, 0)
var ocean_deep = Vector2i(14, 0)
var city_grass = Vector2i(0, 3)
var city_grass_palisade = Vector2i(2, 3)
var castle_grass = Vector2i(4, 3)
var farm = Vector2i(6, 3)
var swamp_forest = Vector2i(8, 3)
var swamp = Vector2i(10, 3)
var swamp_plains = Vector2i(12, 3)
var swamp_sea = Vector2i(14, 3)
var snow_plains = Vector2i(0, 6)
var snow_forest_scarce = Vector2i(2, 6)
var snow_forest_deep = Vector2i(4, 6)
var snow_hill = Vector2i(6, 6)
var snow_hill_forest = Vector2i(8, 6)
var ocean_cold = Vector2i(10, 6)
var city_snow = Vector2i(12, 6)
var castle_snow = Vector2i(14, 6)
var sand_plains = Vector2i(0, 9)
var sand_hill = Vector2i(2, 9)
var sand_dune = Vector2i(4, 9)
var sand_mountain = Vector2i(6, 9)
var sand_oasis = Vector2i(8, 9)
var sand_farm = Vector2i(10, 9)
var city_sand = Vector2i(12, 9)
var castle_sand = Vector2i(14, 9)
var grass_forest_lush = Vector2i(0, 12)
var cave_grass = Vector2i(2, 12)
var cave_snow = Vector2i(4, 12)
var cave_desert = Vector2i(6, 12)
var city_port_NW = Vector2i(8, 12)
var city_port_NE = Vector2i(10, 12)
var lighthouse = Vector2i(12, 12)
var grass_monolith = Vector2i(14, 12)
var city_swamp = Vector2i(0, 15)
#endregion

func generate_world(seed):
	noise.seed = seed
	
	var x : float
	var y : float
	
	for w : float in range(width):
		
		x = floor(-width/4)*3 + floor(w/2)
		y = floor(-heigth/4) - ceil(w/2)
		
		for h : float in range(heigth):
			
			var noise_val = noise.get_noise_2d(w, h)
			var zone = locate_zone(Vector2i(w, h), 8)
			
			if noise_val < -0.6:
				tile_map.set_cell(0, Vector2i(x,y),source_id,grass_forest_lush)
			else:
				tile_map.set_cell(0, Vector2i(x,y),source_id,ocean_deep)
			
			
			x += 1
			y += 1
			


# Called when the node enters the scene tree for the first time.
func _ready():
	noise = noise_height_text.noise
	generate_world(randf()*1000)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func locate_zone(coords : Vector2i, num_zones):
	for x in range(1,num_zones+1):
		if coords.y < ((heigth/num_zones) * (x)):
			return x
