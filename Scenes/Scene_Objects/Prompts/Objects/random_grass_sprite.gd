extends AnimatedSprite3D
@onready var animated_sprite_3d: AnimatedSprite3D = $"."


#var anim_count = animation.count()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite_3d.frame=100
	animated_sprite_3d.frame = randi_range(0, animated_sprite_3d.frame -1)
	#setzt auf max frame zahl, misst dann und setzt auf random nummer zwischen zahl und 0
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
