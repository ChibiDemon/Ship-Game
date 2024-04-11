extends CharacterBody2D
var screen_size

@export var Max_Speed = 400
@export var ACC = 1000
@export var Friction = 500
var direction = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	look_at(get_global_mouse_position())
	 
	

func _process(delta):
	
	direction.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	direction.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	
	direction = direction.normalized()
	
	if direction == Vector2.ZERO:
		if velocity.length() >= Friction * delta:
			velocity -= velocity.normalized()*(Friction*delta)
		else:
			velocity = Vector2.ZERO 
	else:
		velocity += direction*ACC*delta
		velocity = velocity.limit_length(Max_Speed)
	
	move_and_slide()
	
	position = position.clamp(Vector2.ZERO,screen_size)
	
	if position != position.clamp(Vector2.ZERO,screen_size):
		velocity = Vector2.ZERO
	
	
