extends Resource

class_name Biome_Threshold

@export var biome_name : String
@export_range(0,100) var temperature : int = 0
@export_range(0,100) var humidity : int = 0
@export_range(0,100) var heigth : int = 0
@export var biomes : Array[Vector2i]
