extends Camera2D

@export var speed : int
@export var zoom_spd : float

var zoom_trg : float
var zoomin : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	zoom_trg = 1

func _process(delta):
	var velocity = Vector2()
	var zm = Vector2()
	
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_just_released("scroll_up") && zoom_trg <= 2:
		zoom_trg *= 2
		zoomin = true
	if Input.is_action_just_released("scroll_down") && zoom_trg >= 0.5:
		zoom_trg /= 2
		zoomin = false
		
	velocity = velocity.normalized() * speed * delta
	
	if zoom_trg > zoom.x && zoomin:
		zoom *= zoom_spd
	if zoom_trg < zoom.x && !zoomin:
		zoom /= zoom_spd
	
	global_position += velocity