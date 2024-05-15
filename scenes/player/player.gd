extends CharacterBody2D

@export var ACCELERATION : int = 500
@export var MAX_SPEED : int = 200
@export var FRICTION : int = 200

@onready var sprite = $AnimatedSprite2D

func _physics_process(delta):
	move(delta)

func move(delta):
	var input_vector = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		input_vector.x += 1
	if Input.is_action_pressed("move_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("move_down"):
		input_vector.y += 1
	if Input.is_action_pressed("move_up"):
		input_vector.y -= 1
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector.normalized() * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, ACCELERATION * delta)
	move_and_slide()
	
	if velocity != Vector2.ZERO:
		sprite.flip_h = velocity.x < 0
		sprite.play("run")
		sprite.speed_scale = velocity.length()/MAX_SPEED
	else:
		sprite.play("idle")


func _on_tile_clicked(tile_coords : Vector2, global_coords : Vector2):
	position = global_coords
	pass # Replace with function body.
