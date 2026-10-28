extends CharacterBody3D


@onready var animated_sprite_player: AnimatedSprite3D = $Player_Animation
@export_category("Stats")
@export var walking_speed: int = 5
@export var running_speed: int = 7
@export var JUMP_VELOCITY: float = 6


var actual_speed
var animate_state = "idle"
var animate_direction = "down"




func _physics_process(delta: float) -> void:
	## Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
#
	## Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
		
	### Running or Walking
	if Input.is_action_pressed("run"):
		actual_speed = running_speed
	else:
		actual_speed = walking_speed
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * actual_speed
		velocity.z = direction.z * actual_speed
	else:
		velocity.x = move_toward(velocity.x, 0, actual_speed)
		velocity.z = move_toward(velocity.z, 0, actual_speed)
		
	move_and_slide()
	
	
	
	
	### Animation direction
	if (input_dir.y > 0):
		animate_direction = "down"
	elif (input_dir.y < 0):
		animate_direction = "up"
	if (input_dir.x > 0):
		animate_direction = "right"
	elif (input_dir.x < 0):
		animate_direction = "left"

	### Animation State (walk, idle, run, ...)
	if (Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down")):
		if (!Input.is_action_pressed("run")):
			animate_state = "walk"
		else:
			animate_state = "run"
	else: 
		animate_state = "idle"
	
	### reset new animation
	if animated_sprite_player.animation != animate_direction + "_" + animate_state:
		animated_sprite_player.play(animate_direction + "_" + animate_state)
