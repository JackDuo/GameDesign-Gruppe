extends Camera3D

@onready var character_body_3d: CharacterBody3D = $"../CharacterBody3D"

func _ready():
	character_body_3d.apply_floor_snap()
func _process(delta: float) -> void:
	character_body_3d.
	
