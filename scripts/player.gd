extends CharacterBody2D


var SPEED = 130
var JUMP_VELOCITY = -300


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_sound: AudioStreamPlayer = $jump_sound


func _ready() -> void:
	for peach in get_tree().get_nodes_in_group("peaches_group"):
		peach.connect("jump_boost", Callable(self, "_jump_boost"))
	for pear in get_tree().get_nodes_in_group("pears_group"):
		pear.connect("speed_boost", Callable(self, "_speed_boost"))
	for grape in get_tree().get_nodes_in_group("grapes_group"):
		grape.connect("slow_boost", Callable(self, "_slow_boost"))


#func _process(delta: float) -> void:

	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta	

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_sound.play()

	# Get the input direction -1,0,1
	var direction := Input.get_axis("move_left", "move_right")
	
	# turn the character
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true

	if is_on_floor():
		# play the run animation	
		if direction == 0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("jump")
		
		
		
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	
	
func _jump_boost():
#	if has_connections("jump_boost"):
	JUMP_VELOCITY = -500
	print("Starting delay...")
	await get_tree().create_timer(5.0).timeout # Wait for 2 seconds
	print("Delay finished!")
	JUMP_VELOCITY = -300
	
func _speed_boost():
	SPEED = 200
	print("Starting delay...")
	await get_tree().create_timer(5.0).timeout # Wait for 2 seconds
	print("Delay finished!")
	SPEED = 130
	
func _slow_boost():
	SPEED = 50
	print("Starting delay...")
	await get_tree().create_timer(5.0).timeout # Wait for 2 seconds
	print("Delay finished!")
	SPEED = 130
	
	
