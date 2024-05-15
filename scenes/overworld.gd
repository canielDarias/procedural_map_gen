extends Node2D

@export var noise_height_text : NoiseTexture2D
@export var temperature_noise_text : NoiseTexture2D
@export var humidity_noise_text : NoiseTexture2D
var heigth_noise : Noise
var temperature_noise : Noise
var humidity_noise : Noise

var width : int = 640
var heigth : int = 480
@onready var tile_map = $TileMap
@onready var player = $Player

signal tile_clicked

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

var biome = []

func generate_world():
	heigth_noise.seed = randf()*1000
	temperature_noise.seed = randf()*1000
	humidity_noise.seed = randf()*1000
	
	var x : float
	var y : float
	
	for w : float in range(width):
		
		x = floor(-width/4)*3 + floor(w/2)
		y = floor(-heigth/4) - ceil(w/2)
		
		for h : float in range(heigth):
			
			var heigth_val = heigth_noise.get_noise_2d(w*4, h*4)
			var temperature_val = temperature_noise.get_noise_2d(w, h)
			var humidity_val = humidity_noise.get_noise_2d(w, h)
			
			if heigth_val < -0.2:
				tile_map.set_cell(-1, Vector2i(x,y),source_id,ocean_deep)
			elif heigth_val < 0:
				tile_map.set_cell(0, Vector2i(x,y),source_id,ocean_shallow)
			elif heigth_val < 0.1:
				if temperature_val <= 0.4 && randf() < 0.05:
					tile_map.set_cell(0, Vector2i(x,y),source_id,ocean_cold)
				else:
					tile_map.set_cell(0, Vector2i(x,y),source_id,ocean_shallow)
			
			elif heigth_val < 0.45:
				if temperature_val < -0.75:
					tile_map.set_cell(0, Vector2i(x,y),source_id,snow_plains)
				if temperature_val < -0.25:
					if humidity_val < -0.75:
						tile_map.set_cell(0, Vector2i(x,y),source_id,swamp_plains)
					else:
						tile_map.set_cell(0, Vector2i(x,y),source_id,snow_forest_scarce)
				if temperature_val < 0.5:
					if humidity_val < -0.75:
						tile_map.set_cell(0, Vector2i(x,y),source_id,sand_plains)
					elif humidity_val < -0.5:
						tile_map.set_cell(0, Vector2i(x,y),source_id,sand_plains)
					elif humidity_val < 0:
						tile_map.set_cell(0, Vector2i(x,y),source_id,grass_plains)
					elif humidity_val < 0.5:
						tile_map.set_cell(0, Vector2i(x,y),source_id,grass_forest_deep)
					else:
						tile_map.set_cell(0, Vector2i(x,y),source_id,grass_forest_lush)
				else:
					if humidity_val < -0.75:
						tile_map.set_cell(0, Vector2i(x,y),source_id,sand_plains)
					elif humidity_val < -0.5:
						tile_map.set_cell(0, Vector2i(x,y),source_id,sand_plains)
					elif humidity_val < 0.25:
						tile_map.set_cell(0, Vector2i(x,y),source_id,grass_plains)
					else:
						tile_map.set_cell(0, Vector2i(x,y),source_id,grass_forest_lush)
				
			elif heigth_val < 0.55:
				if temperature_val < -0.25:
					tile_map.set_cell(0, Vector2i(x,y),source_id,snow_hill)
				if temperature_val < 0.5:
					if humidity_val < -0.5:
						tile_map.set_cell(0, Vector2i(x,y),source_id,grass_hill)
					elif humidity_val < 0:
						tile_map.set_cell(0, Vector2i(x,y),source_id,grass_hill)
					else:
						tile_map.set_cell(0, Vector2i(x,y),source_id,grass_hill_forest)
				else:
					if humidity_val < 0:
						tile_map.set_cell(0, Vector2i(x,y),source_id,sand_hill)
					elif humidity_val < 0.5:
						tile_map.set_cell(0, Vector2i(x,y),source_id,grass_hill)
					else:
						tile_map.set_cell(0, Vector2i(x,y),source_id,grass_hill_forest)
				
			else:
				tile_map.set_cell(0, Vector2i(x,y),source_id,mountain)
			
			x += 1
			y += 1
			


# Called when the node enters the scene tree for the first time.
func _ready():
	heigth_noise = noise_height_text.noise
	temperature_noise = temperature_noise_text.noise
	humidity_noise = humidity_noise_text.noise
	generate_world()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed("ui_accept"):
		generate_world()
		
	if Input.is_action_just_released("cursor_click"):
		var cell_coords = tile_map.local_to_map(tile_map.get_local_mouse_position())
		var cell_type_index = tile_map.to_local(cell_coords)
		#print(tile_map.tile_set.tile_get_name(cell_type_index))
		var cell_world_pos_local = tile_map.map_to_local(cell_coords)
		var cell_world_pos_global = tile_map.to_global(cell_world_pos_local)
		player.global_position = cell_world_pos_global + tile_map.rendering_quadrant_size/2
