extends Camera2D

@export var speed : int
@export var zoom_spd : float
@export var zoom_up_limit : float = 4
@export var zoom_down_limit : float = 0.25

var zoom_trg : float
var zoomin : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	zoom_trg = 1

func _process(_delta):
	if Input.is_action_just_released("scroll_up") && zoom_trg <= pow(zoom_up_limit, 2)/2:
		zoom_trg *= 2
		zoomin = true
	if Input.is_action_just_released("scroll_down") && zoom_trg >= 2/pow(zoom_down_limit, 2):
		zoom_trg /= 2
		zoomin = false
	
	if zoom_trg > zoom.x && zoomin:
		zoom *= zoom_spd
	if zoom_trg < zoom.x && !zoomin:
		zoom /= zoom_spd
