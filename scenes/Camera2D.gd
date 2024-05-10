extends Camera2D

@export var speed : int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	var velocity = Vector2()
	if Input.is_action_pressed("move_right"):
			velocity.x += 1
	if Input.is_action_pressed("move_left"):
			velocity.x -= 1
	if Input.is_action_pressed("move_down"):
			velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		
	velocity = velocity.normalized() * speed * delta
	global_position += velocity
