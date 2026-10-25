extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var _animated_sprite = $Player
var now_direction = "down"
var direction_map = ["up", "down", "left", "right"]

func get_direction():
	
#das ist ein Beispiel für lesbaren, schönen und produktiven code
	for i in range(4):
		if Input.is_action_pressed("ui_" + direction_map[i]):
			now_direction = direction_map[i]
	
	

func _process(_delta):
	if Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down"):
		get_direction()
		_animated_sprite.play("walking_" + now_direction)
	else:
		_animated_sprite.stop()
		_animated_sprite.play("idle_" + now_direction)




func _physics_process(_delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
